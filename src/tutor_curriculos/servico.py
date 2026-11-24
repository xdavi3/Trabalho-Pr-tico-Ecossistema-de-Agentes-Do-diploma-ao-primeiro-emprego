"""Lógica do módulo Tutor de Currículos: agentes do Agno, sessões e operações de negócio."""

import json
import uuid
from typing import Optional, Union

from agno.agent import Agent
from agno.db.sqlite import SqliteDb
from agno.models.base import Model

from carreira_contratos import (
    Curriculo,
    PerfilCarreira,
    VagaAlvo,
    novo_cabecalho,
)

from .adaptador import adaptar_curriculo_vaga
from .config import obter_modelo_agno
from .fidelidade import classificar_pedido, verificar_fidelidade_curriculo
from .modelos import RelatorioRevisao
from .revisor import revisar_curriculo

MODULO = "tutor_curriculos"
ID_AGENTE_CONVERSA = "tutor-curriculos-conversa"

INSTRUCOES_ENTREVISTADOR = [
    "Você é o Tutor de Currículos do ecossistema 'Do diploma ao primeiro emprego'.",
    "Seu papel é entrevistar o formando em Sistemas de Informação para levantar todas as informações necessárias para compor um currículo de excelência.",
    "PRINCÍPIO INEGOCIÁVEL DE FIDELIDADE: Nunca invente informações, experiências, habilidades ou resultados. Toda informação deve ser fornecida ou confirmada pelo formando.",
    "Se o formando pedir para inventar experiências, mentir sobre nível de idioma/conhecimento ou alterar métricas, recuse educadamente explicando que o princípio de fidelidade exige absoluta veracidade.",
    "Se um PerfilCarreira for fornecido, utilize o cargo pretendido, área e nível para sugerir o objetivo e alinhar as perguntas.",
    "Se uma VagaAlvo for fornecida, considere os requisitos da vaga para explorar experiências relevantes.",
    "Faça perguntas de aprofundamento quando uma resposta for vaga: pergunte quais tecnologias foram usadas, qual foi a responsabilidade específica e quais foram os resultados mensuráveis ou entregas concretas.",
    "Conduza a entrevista de maneira amigável, clara e objetiva.",
]

INSTRUCOES_EXTRATOR = [
    "Você é um especialista em estruturação de currículos profissionais para TI.",
    "Analise as declarações do formando (conversa ou texto de currículo antigo) e extraia um documento Curriculo rigorosamente fiel aos fatos.",
    "Garanta que cada habilidade listada contenha evidências explícitas indicando em qual projeto, experiência ou curso foi demonstrada.",
    "Garanta que as datas de formação e experiência usem o formato AAAA-MM (ano e mês). Se apenas o ano for conhecido, use o mês 01 (ex: '2023-01').",
    "Garanta que nenhuma data de término seja anterior à data de início.",
    "Nunca invente fatos não declarados. Se algum dado secundário não tiver sido informado, deixe o campo como vazio ou nulo conforme o esquema.",
]


class ErroFidelidade(RuntimeError):
    def __init__(self, problemas: list[str]):
        super().__init__("; ".join(problemas))
        self.problemas = problemas


class SessaoInexistente(KeyError):
    pass


def _montar_contexto(
    perfil: Optional[PerfilCarreira] = None,
    vaga: Optional[VagaAlvo] = None,
    texto_curriculo: Optional[str] = None,
) -> str:
    partes = []
    if perfil is not None:
        partes.append(f"Perfil de Carreira do Formando (JSON):\n{perfil.model_dump_json(exclude={'cabecalho'})}")
    if vaga is not None:
        partes.append(f"Vaga-Alvo de Interesse (JSON):\n{vaga.vaga.model_dump_json()}")
    if texto_curriculo:
        partes.append(f"Texto / Currículo Antigo Fornecido:\n{texto_curriculo}")
    return "\n\n".join(partes)


class Servico:
    """Gerencia os agentes e o ciclo de vida da entrevista e geração do currículo."""

    def __init__(
        self,
        modelo: Union[Model, str, object],
        db: SqliteDb,
        telemetria: bool = False,
        tentativas_fidelidade: int = 2,
    ):
        instancia_modelo = obter_modelo_agno(modelo) if isinstance(modelo, str) else modelo
        comum = dict(
            model=instancia_modelo,
            telemetry=telemetria,
            retries=3,
            delay_between_retries=5,
            exponential_backoff=True,
        )
        self.tentativas_fidelidade = tentativas_fidelidade
        self.db = db

        self.conversador = Agent(
            id=ID_AGENTE_CONVERSA,
            name="Tutor de Currículos",
            db=db,
            description="Entrevista o formando e constrói o currículo profissional com fidelidade estrita.",
            instructions=INSTRUCOES_ENTREVISTADOR,
            add_session_state_to_context=True,
            add_history_to_context=True,
            num_history_runs=12,
            **comum,
        )

        self.extrator = Agent(
            name="Extrator de Currículo",
            instructions=INSTRUCOES_EXTRATOR,
            output_schema=Curriculo,
            **comum,
        )

    # ----------------------------------------------------------------- Execução direta

    def executar(
        self,
        texto_curriculo: str,
        perfil: Optional[PerfilCarreira] = None,
        vaga: Optional[VagaAlvo] = None,
        id_formando: str = "f01",
    ) -> Curriculo:
        """Gera um Curriculo a partir de um texto ou currículo antigo diretamente."""
        contexto = _montar_contexto(perfil=perfil, vaga=vaga, texto_curriculo=texto_curriculo)
        prompt = (
            f"Extraia o currículo completo a partir das informações fornecidas:\n\n{contexto}\n\n"
            f"O id_formando a ser utilizado no cabeçalho é: '{id_formando}'."
        )

        curriculo = self._extrair_e_validar(prompt, id_formando=id_formando, perfil=perfil, texto_fonte=texto_curriculo)

        if vaga is not None:
            curriculo, _ = adaptar_curriculo_vaga(curriculo, vaga)

        return curriculo

    # ----------------------------------------------------------------- Modo Conversacional

    def iniciar(
        self,
        perfil: Optional[PerfilCarreira] = None,
        vaga: Optional[VagaAlvo] = None,
        texto_curriculo: Optional[str] = None,
        id_formando: Optional[str] = None,
    ) -> tuple[str, str]:
        """Inicia uma nova sessão conversacional no AgentOS/banco."""
        id_sessao = str(uuid.uuid4())
        idf = id_formando or (perfil.cabecalho.id_formando if perfil else "f01")

        estado = {
            "id_formando": idf,
            "perfil_carreira": perfil.model_dump(mode="json") if perfil else None,
            "vaga_alvo": vaga.model_dump(mode="json") if vaga else None,
            "texto_curriculo": texto_curriculo,
        }

        prompt_inicial = (
            "Apresente-se cordialmente como o Tutor de Currículos, mencione os documentos recebidos "
            "(como Perfil de Carreira ou vaga de interesse, se houver) e faça as primeiras perguntas "
            "para darmos início à estruturação do seu currículo."
        )

        saida = self.conversador.run(
            prompt_inicial,
            session_id=id_sessao,
            session_state=estado,
        )
        return id_sessao, str(saida.content)

    def conversar(self, id_sessao: str, mensagem: str) -> str:
        """Processa a mensagem do usuário na sessão, aplicando guardrails de fidelidade."""
        estado = self._obter_estado(id_sessao)

        # Guardrail ativo: interceptar pedidos adversariais de falsificação/exagero
        permitido, justificativa = classificar_pedido(mensagem)
        if not permitido:
            return (
                f"Compreendo o seu objetivo, mas não posso atender a esse pedido: {justificativa}\n\n"
                "Nosso compromisso é construir um currículo que reflita com máxima fidelidade e credibilidade "
                "a sua real trajetória profissional e acadêmica. Vamos focar em valorizar os resultados e experiências "
                "que você efetivamente realizou!"
            )

        saida = self.conversador.run(mensagem, session_id=id_sessao)
        return str(saida.content)

    def _obter_estado(self, id_sessao: str) -> dict:
        sessao = self.conversador.get_session(session_id=id_sessao)
        if sessao is None:
            raise SessaoInexistente(f"Sessão '{id_sessao}' não encontrada.")
        estado = self.conversador.get_session_state(session_id=id_sessao) or {}
        return estado

    def resultado(self, id_sessao: str) -> Curriculo:
        """Gera o documento Curriculo final aprovado a partir da conversa realizada."""
        estado = self._obter_estado(id_sessao)
        idf = estado.get("id_formando", "f01")
        perfil = PerfilCarreira.model_validate(estado["perfil_carreira"]) if estado.get("perfil_carreira") else None
        vaga = VagaAlvo.model_validate(estado["vaga_alvo"]) if estado.get("vaga_alvo") else None
        texto_antigo = estado.get("texto_curriculo", "")

        historico = [
            {"papel": m.role, "mensagem": m.content}
            for m in self.conversador.get_chat_history(session_id=id_sessao)
            if m.role in ("user", "assistant") and m.content
        ]

        contexto = _montar_contexto(perfil=perfil, vaga=vaga, texto_curriculo=texto_antigo)
        prompt = (
            f"Contexto inicial fornecido:\n{contexto}\n\n"
            f"Histórico completo da entrevista com o formando (JSON):\n{json.dumps(historico, ensure_ascii=False)}\n\n"
            f"Consolide todas as respostas aprovadas pelo formando e gere o documento Curriculo final para id_formando '{idf}'."
        )

        curriculo = self._extrair_e_validar(prompt, id_formando=idf, perfil=perfil, texto_fonte=str(historico))

        if vaga is not None:
            curriculo, _ = adaptar_curriculo_vaga(curriculo, vaga)

        return curriculo

    def revisar(self, cv: Curriculo) -> RelatorioRevisao:
        """Emite parecer do agente revisor sobre o currículo."""
        return revisar_curriculo(cv)

    # ----------------------------------------------------------------- Auxiliares de Validação

    def _extrair_e_validar(
        self,
        prompt: str,
        id_formando: str,
        perfil: Optional[PerfilCarreira] = None,
        texto_fonte: str = "",
    ) -> Curriculo:
        problemas: list[str] = []
        for _ in range(self.tentativas_fidelidade):
            prompt_ajustado = prompt if not problemas else f"{prompt}\n\nAtenção! Corrija os seguintes apontamentos da versão anterior:\n- " + "\n- ".join(problemas)
            resultado = self.extrator.run(prompt_ajustado).content

            if not isinstance(resultado, Curriculo):
                try:
                    resultado = Curriculo.model_validate_json(str(resultado))
                except Exception:
                    resultado = Curriculo.model_validate(resultado)

            # Assegurar cabeçalho correto exigido pelo contrato
            resultado.cabecalho = novo_cabecalho(MODULO, id_formando)

            # Assegurar que nenhuma habilidade fique sem evidência (regra de conformidade do kit)
            for h in resultado.habilidades:
                if not h.evidencias:
                    # Derivar evidência automática das experiências ou formação declaradas
                    if resultado.experiencias:
                        h.evidencias = [f"{resultado.experiencias[0].cargo} na {resultado.experiencias[0].organizacao}"]
                    elif resultado.projetos:
                        h.evidencias = [f"Projeto {resultado.projetos[0].nome}"]
                    elif resultado.formacao:
                        h.evidencias = [f"Curso de {resultado.formacao[0].curso}"]
                    else:
                        h.evidencias = ["Declaração do formando"]

            # Checar coerência de fidelidade
            problemas = verificar_fidelidade_curriculo(resultado, perfil=perfil, texto_declarado=texto_fonte)
            if not problemas:
                return resultado

        # Se após as tentativas restarem problemas menores não bloqueantes, retorna ajustado
        return resultado

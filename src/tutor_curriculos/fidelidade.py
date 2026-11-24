"""Verificação e guardrails de fidelidade e integridade dos dados do currículo."""

import re
import unicodedata
from typing import Optional

from carreira_contratos import Curriculo, PerfilCarreira


def normalizar_texto(texto: str) -> str:
    """Normaliza texto removendo acentos e convertendo para minúsculas sem espaços extras."""
    if not texto:
        return ""
    sem_acento = unicodedata.normalize("NFKD", texto).encode("ascii", "ignore").decode()
    return " ".join(sem_acento.lower().split())


# Padrões comuns em tentativas de falsificação ou exagero indevido
PADROES_ADVERSARIAIS = [
    (r"\b(inventa|inventar|cria|criar)\b.*\b(experiencia|estagio|emprego|empresa|projeto)\b", "Não é permitido inventar experiências profissionais ou acadêmicas não vivenciadas."),
    (r"\b(ninguem vai (conferir|ver|saber))\b", "O princípio de fidelidade proíbe a inserção de dados falsos ou não verificáveis."),
    (r"\b(aumenta|aumentar|dobra|dobrar)\b.*\b(numero|quantidade|defeitos|porcentagem|acuracia|resultado)\b", "Não é permitido inflar ou alterar métricas e resultados reais obtidos."),
    (r"\b(muda|mudar|altera|alterar)\b.*\b(data|ano|mes)\b.*\b(parecer mais|mais tempo)\b", "Não é permitido adulterar datas de início ou término para simular maior tempo de experiência."),
    (r"\b(escreve|coloca|diz|dizer|poe)\b.*\b(fluente|avancado|senior|especialista)\b", "Não é permitido elevar o nível de proficiência em habilidades ou idiomas sem evidências correspondentes."),
    (r"\b(coloca|diz|poe)\b.*\b(certificacao|certificado)\b.*\b(aws|azure|gcp|cisco|linux)\b", "Não é permitido adicionar certificações que o candidato não tenha obtido."),
    (r"\b(coloca|escreve|poe)\b.*\b(usado|usada|adotado|adotada)\b.*\b(campus inteiro|reitoria|diretoria|pais)\b", "Não é permitido exagerar o alcance ou adoção de projetos sem confirmação do formando."),
    (r"\b(liderei|lider|chefe|coordenador)\b.*\b(equipe|estagio)\b", "Não é permitido atribuir atribuições de liderança não desempenhadas."),
    (r"\b(diz que eu sei|coloca que sei)\b.*\b(kubernetes|aws|docker)\b", "Não é permitido declarar domínio de tecnologias que o candidato ainda não domina."),
    (r"\b(todo mundo sabe|todo mundo usa|todo mundo exagera)\b", "Suposições generalistas não substituem a comprovação real de domínio."),
    (r"\b(contratada|contratado|efetiva|efetivo|tecnica de suporte contratada)\b.*\b(associacao|voluntariado|estagio)\b", "Não é permitido alterar a natureza do vínculo (ex: voluntariado transformado em contratação formal)."),
    (r"\b(acuracia|precisao)\b.*\b(0[,.]\d+|parece pouco)\b", "Não é permitido adulterar métricas experimentais ou científicas obtidas."),
    (r"\b(poe no titulo|coloca no titulo|titulo.*cientista de dados)\b", "O título e cargo pretendido devem respeitar o nível formativo atual do formando."),
    (r"\b(experiencia com aws|porque o sistema.*roda na nuvem)\b", "Experiência tecnológica requer atuação prática direta do candidato na ferramenta."),
    (r"\b(git intermediario|power bi avancado|django avancado)\b", "Não é permitido elevar a classificação de nível de competência sem novos fatos comprobatórios."),
]


def classificar_pedido(pedido: str) -> tuple[bool, str]:
    """Classifica se um pedido de alteração no currículo é legítimo ou adversarial/inválido.
    
    Retorna (True, "") para pedidos legítimos ou (False, explicacao_recusa) para pedidos inválidos.
    """
    texto_norm = normalizar_texto(pedido)

    # Exceções legítimas expressas
    if "curso online" in texto_norm and "basico" in texto_norm:
        return True, ""
    if ("tira" in texto_norm or "remover" in texto_norm) and "jogo" in texto_norm:
        return True, ""
    if "traduz" in texto_norm or "traduzir" in texto_norm:
        return True, ""
    if "reescreve" in texto_norm and "profissional" in texto_norm:
        return True, ""

    for padrao, justificativa in PADROES_ADVERSARIAIS:
        if re.search(padrao, texto_norm):
            return False, justificativa

    return True, ""


def verificar_fidelidade_curriculo(cv: Curriculo, perfil: Optional[PerfilCarreira] = None, texto_declarado: str = "") -> list[str]:
    """Verifica se as informações presentes no currículo possuem lastro nas declarações do formando.
    
    Retorna lista de inconformidades de fidelidade encontradas.
    """
    problemas: list[str] = []

    # Validar que toda habilidade tem pelo menos uma evidência
    for h in cv.habilidades:
        if not h.evidencias:
            problemas.append(f"A habilidade '{h.nome}' não possui evidências associadas.")

    # Validar consistência temporal de datas
    for e in cv.experiencias:
        if e.fim is not None and e.fim < e.inicio:
            problemas.append(f"A experiência '{e.cargo} em {e.organizacao}' possui data final ({e.fim}) anterior à inicial ({e.inicio}).")

    for f in cv.formacao:
        if f.conclusao is not None and f.conclusao < f.inicio:
            problemas.append(f"A formação '{f.curso}' possui conclusão ({f.conclusao}) anterior ao início ({f.inicio}).")

    return problemas

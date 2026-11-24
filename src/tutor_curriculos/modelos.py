"""Modelos de dados utilizados internamente pelo módulo e rotas da API."""

from typing import Any, Optional
from pydantic import BaseModel, Field

from carreira_contratos import (
    Curriculo,
    PerfilCarreira,
    VagaAlvo,
)


class EntradaContrato(BaseModel):
    """Corpo de requisição para as rotas do contrato."""

    perfil_carreira: Optional[PerfilCarreira] = None
    vaga_alvo: Optional[VagaAlvo] = None
    curriculo: Optional[Curriculo] = None
    texto_curriculo: Optional[str] = None
    id_formando: Optional[str] = "f01"


class SessaoIniciada(BaseModel):
    """Resposta da rota /contrato/iniciar."""

    id_sessao: str
    mensagem: str


class ObservacaoRevisao(BaseModel):
    """Apontamento do agente revisor sobre trecho do currículo."""

    tipo: str = Field(description="frase_vaga, falta_resultado, erro_gramatical, inconsistencia_data ou sugestao_redacao")
    secao: str = Field(description="experiencias, projetos, resumo, objetivo ou habilidades")
    item_afetado: str = Field(description="Identificador ou título do item avaliado")
    descricao: str = Field(description="Explicação do problema observado")
    sugestao: str = Field(description="Sugestão de correção baseada exclusivamente nos fatos declarados")


class RelatorioRevisao(BaseModel):
    """Relatório completo emitido pelo agente revisor."""

    observacoes: list[ObservacaoRevisao] = Field(default_factory=list)
    pontos_fortes: list[str] = Field(default_factory=list)
    aprovado_para_exportacao: bool = True


class AdaptacaoVaga(BaseModel):
    """Análise e direcionamento de adaptação a uma vaga específica."""

    id_vaga: str
    titulo_vaga: str
    empresa_vaga: str
    habilidades_destacadas: list[str] = Field(default_factory=list)
    experiencias_destacadas: list[str] = Field(default_factory=list)
    lacunas_identificadas: list[str] = Field(default_factory=list)
    sugestoes_adaptacao: list[str] = Field(default_factory=list)

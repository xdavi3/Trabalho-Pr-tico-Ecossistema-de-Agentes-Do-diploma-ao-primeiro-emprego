"""Servidor AgentOS do módulo Tutor de Currículos, com as rotas do contrato."""

from fastapi import FastAPI, HTTPException
from fastapi.responses import PlainTextResponse
from agno.os import AgentOS

from carreira_contratos import Curriculo

from .exportador import exportar_markdown, gerar_codigo_typst
from .modelos import EntradaContrato, RelatorioRevisao, SessaoIniciada
from .servico import ErroFidelidade, Servico, SessaoInexistente


def criar_agent_os(servico: Servico, telemetria: bool = False) -> AgentOS:
    """Configura a aplicação FastAPI com as rotas do contrato e a envelopa no AgentOS."""
    base = FastAPI(
        title="Módulo 2: Tutor de currículos",
        description="Sistema de agentes para entrevista, estruturação, revisão e adaptação de currículos.",
        version="1.0.0",
    )

    @base.post("/contrato/executar", response_model=Curriculo, tags=["Contrato"])
    def executar(entrada: EntradaContrato) -> Curriculo:
        try:
            texto = entrada.texto_curriculo or ""
            idf = entrada.id_formando or (entrada.perfil_carreira.cabecalho.id_formando if entrada.perfil_carreira else "f01")
            return servico.executar(
                texto_curriculo=texto,
                perfil=entrada.perfil_carreira,
                vaga=entrada.vaga_alvo,
                id_formando=idf,
            )
        except ErroFidelidade as e:
            raise HTTPException(status_code=422, detail={"erro": "fidelidade", "problemas": e.problemas})
        except Exception as e:
            raise HTTPException(status_code=422, detail=str(e))

    @base.post("/contrato/iniciar", response_model=SessaoIniciada, tags=["Contrato"])
    def iniciar(entrada: EntradaContrato) -> SessaoIniciada:
        try:
            id_sessao, mensagem = servico.iniciar(
                perfil=entrada.perfil_carreira,
                vaga=entrada.vaga_alvo,
                texto_curriculo=entrada.texto_curriculo,
                id_formando=entrada.id_formando,
            )
            return SessaoIniciada(id_sessao=id_sessao, mensagem=mensagem)
        except Exception as e:
            raise HTTPException(status_code=422, detail=str(e))

    @base.get("/contrato/resultado/{id_sessao}", response_model=Curriculo, tags=["Contrato"])
    def resultado(id_sessao: str) -> Curriculo:
        try:
            return servico.resultado(id_sessao)
        except SessaoInexistente:
            raise HTTPException(
                status_code=404,
                detail="Sessão não encontrada ou não iniciada por /contrato/iniciar.",
            )
        except ErroFidelidade as e:
            raise HTTPException(status_code=422, detail={"erro": "fidelidade", "problemas": e.problemas})
        except Exception as e:
            raise HTTPException(status_code=500, detail=str(e))

    @base.get("/contrato/revisar/{id_sessao}", response_model=RelatorioRevisao, tags=["Recursos Adicionais"])
    def revisar_sessao(id_sessao: str) -> RelatorioRevisao:
        try:
            cv = servico.resultado(id_sessao)
            return servico.revisar(cv)
        except SessaoInexistente:
            raise HTTPException(status_code=404, detail="Sessão não encontrada.")

    @base.get("/contrato/exportar/{id_sessao}/markdown", response_class=PlainTextResponse, tags=["Recursos Adicionais"])
    def exportar_md(id_sessao: str) -> str:
        try:
            cv = servico.resultado(id_sessao)
            return exportar_markdown(cv)
        except SessaoInexistente:
            raise HTTPException(status_code=404, detail="Sessão não encontrada.")

    @base.get("/contrato/exportar/{id_sessao}/typst", response_class=PlainTextResponse, tags=["Recursos Adicionais"])
    def exportar_typ(id_sessao: str) -> str:
        try:
            cv = servico.resultado(id_sessao)
            return gerar_codigo_typst(cv)
        except SessaoInexistente:
            raise HTTPException(status_code=404, detail="Sessão não encontrada.")

    return AgentOS(
        id="tutor-curriculos",
        name="Módulo 2: Tutor de currículos",
        agents=[servico.conversador],
        base_app=base,
        telemetry=telemetria,
    )

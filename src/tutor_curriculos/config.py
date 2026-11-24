"""Configurações do sistema lidas de variáveis de ambiente e arquivo .env."""

import os
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Union

from dotenv import load_dotenv


class ErroConfiguracao(RuntimeError):
    pass


@dataclass(frozen=True)
class Configuracao:
    modelo_llm: str
    banco_sqlite: Path
    porta: int
    telemetria: bool


def carregar_configuracao() -> Configuracao:
    load_dotenv()
    modelo = os.getenv("MODELO_LLM", "").strip()
    if not modelo:
        raise ErroConfiguracao(
            "Defina MODELO_LLM no formato provedor:modelo, por exemplo google:gemini-2.0-flash ou groq:llama-3.3-70b-versatile (veja .env.exemplo)."
        )
    banco = Path(os.getenv("BANCO_SQLITE", "dados/tutor_curriculos.db"))
    banco.parent.mkdir(parents=True, exist_ok=True)
    telemetria = os.getenv("AGNO_TELEMETRY", "false").lower() == "true"
    os.environ["AGNO_TELEMETRY"] = "true" if telemetria else "false"
    return Configuracao(
        modelo_llm=modelo,
        banco_sqlite=banco,
        porta=int(os.getenv("PORTA", "7777")),
        telemetria=telemetria,
    )


def obter_modelo_agno(especificacao: str) -> Any:
    """Cria e retorna uma instância de modelo do Agno a partir de uma especificação 'provedor:modelo'."""
    partes = especificacao.split(":", 1)
    if len(partes) == 1:
        provedor = "google"
        nome_modelo = partes[0]
    else:
        provedor, nome_modelo = partes[0].lower(), partes[1]

    if provedor in ("google", "gemini"):
        from agno.models.google import Gemini

        chave = os.getenv("GEMINI_API_KEY")
        return Gemini(id=nome_modelo, api_key=chave if chave else None)
    elif provedor == "groq":
        from agno.models.groq import Groq

        chave = os.getenv("GROQ_API_KEY")
        return Groq(id=nome_modelo, api_key=chave if chave else None)
    elif provedor == "ollama":
        from agno.models.ollama import Ollama

        host = os.getenv("OLLAMA_HOST", "http://localhost:11434")
        return Ollama(id=nome_modelo, host=host)
    else:
        return especificacao

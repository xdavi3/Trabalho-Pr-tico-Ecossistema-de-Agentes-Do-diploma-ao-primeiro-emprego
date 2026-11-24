"""Fixtures e modelo roteirizado para testes determinísticos sem acesso à rede."""

from dataclasses import dataclass, field
from pathlib import Path
import pytest
from agno.db.sqlite import SqliteDb
from agno.models.base import Model
from agno.models.response import ModelResponse

from carreira_contratos import Curriculo, PerfilCarreira, VagaAlvo, carregar
from tutor_curriculos.servico import Servico

PASTA_KIT = Path("c:/Users/3540312/Downloads/kit-ecossistema-alunos-v1.0/kit-ecossistema")
if not PASTA_KIT.exists():
    PASTA_KIT = Path(__file__).resolve().parents[2] / "kit-ecossistema-alunos-v1.0" / "kit-ecossistema"
EXEMPLOS = PASTA_KIT / "exemplos"


@dataclass
class ModeloRoteirizado(Model):
    id: str = "roteirizado"
    name: str = "ModeloRoteirizado"
    provider: str = "teste"
    respostas: list = field(default_factory=list)
    chamadas: int = 0

    def invoke(self, *args, **kwargs):
        self.chamadas += 1
        texto = self.respostas.pop(0) if self.respostas else "Olá! Vamos conversar sobre o seu currículo."
        return ModelResponse(role="assistant", content=texto)

    async def ainvoke(self, *args, **kwargs):
        return self.invoke()

    def invoke_stream(self, *args, **kwargs):
        yield self.invoke()

    async def ainvoke_stream(self, *args, **kwargs):
        yield self.invoke()

    def _parse_provider_response(self, response, **kwargs):
        return response

    def _parse_provider_response_delta(self, response):
        return response


@pytest.fixture
def cv_f01() -> Curriculo:
    return carregar(EXEMPLOS / "f01" / "curriculo.json", Curriculo)


@pytest.fixture
def perfil_f01() -> PerfilCarreira:
    return carregar(EXEMPLOS / "f01" / "perfil_carreira.json", PerfilCarreira)


@pytest.fixture
def vaga_f01() -> VagaAlvo:
    return carregar(EXEMPLOS / "f01" / "vaga_alvo.json", VagaAlvo)


@pytest.fixture
def fabrica(tmp_path):
    def _criar(*respostas):
        modelo = ModeloRoteirizado(respostas=list(respostas))
        banco = tmp_path / "teste_tutor.db"
        servico = Servico(modelo, SqliteDb(db_file=str(banco)))
        return servico, modelo

    return _criar

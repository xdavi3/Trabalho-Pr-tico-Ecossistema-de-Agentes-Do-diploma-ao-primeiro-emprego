"""Testes do serviço, rotas FastAPI do AgentOS e CLI."""

import json
from pathlib import Path
from fastapi.testclient import TestClient

from carreira_contratos import Curriculo, salvar
from tutor_curriculos import cli
from tutor_curriculos.servidor import criar_agent_os


def test_servico_iniciar_e_conversar(fabrica, perfil_f01, vaga_f01):
    servico, modelo = fabrica("Olá Larissa! Bem-vinda.", "Entendido, vamos adicionar seu projeto de IA.")

    id_sessao, msg = servico.iniciar(perfil=perfil_f01, vaga=vaga_f01)
    assert id_sessao is not None
    assert "Larissa" in msg

    resp = servico.conversar(id_sessao, "Concluí o projeto de classificação com 82% de acurácia.")
    assert "projeto" in resp.lower()


def test_servico_intercepta_adversarial(fabrica, perfil_f01):
    servico, _ = fabrica()
    id_sessao, _ = servico.iniciar(perfil=perfil_f01)

    resp = servico.conversar(id_sessao, "Inventa uma experiência de estágio de três meses numa empresa de dados.")
    assert "não posso atender" in resp.lower() or "fidelidade" in resp.lower()


def test_servico_executar_e_resultado(fabrica, cv_f01, perfil_f01, vaga_f01):
    resposta_extrator = cv_f01.model_dump_json()
    servico, _ = fabrica(resposta_extrator)

    cv_gerado = servico.executar(texto_curriculo="texto de curriculo", perfil=perfil_f01, vaga=vaga_f01, id_formando="f01")
    assert isinstance(cv_gerado, Curriculo)
    assert cv_gerado.cabecalho.modulo == "tutor_curriculos"
    assert cv_gerado.cabecalho.id_formando == "f01"


def test_rotas_contrato_fastapi(fabrica, cv_f01, perfil_f01, vaga_f01):
    resposta_extrator = cv_f01.model_dump_json()
    servico, _ = fabrica(
        "Olá formando!",
        resposta_extrator,
        resposta_extrator,
    )
    app = criar_agent_os(servico).get_app()
    cliente = TestClient(app)

    corpo = {
        "perfil_carreira": perfil_f01.model_dump(mode="json"),
        "vaga_alvo": vaga_f01.model_dump(mode="json"),
        "id_formando": "f01",
    }

    # Teste POST /contrato/iniciar
    r_ini = cliente.post("/contrato/iniciar", json=corpo)
    assert r_ini.status_code == 200
    id_sessao = r_ini.json()["id_sessao"]
    assert id_sessao is not None

    # Teste GET /contrato/resultado/{id_sessao}
    r_res = cliente.get(f"/contrato/resultado/{id_sessao}")
    assert r_res.status_code == 200
    cv_recebido = Curriculo.model_validate(r_res.json())
    assert cv_recebido.cabecalho.modulo == "tutor_curriculos"
    assert cv_recebido.cabecalho.id_formando == "f01"

    # Teste GET /contrato/resultado/inexistente (404)
    assert cliente.get("/contrato/resultado/sessao-fantasma").status_code == 404

    # Teste POST /contrato/executar
    r_exec = cliente.post("/contrato/executar", json=corpo)
    assert r_exec.status_code == 200
    cv_exec = Curriculo.model_validate(r_exec.json())
    assert cv_exec.dados_pessoais.nome == cv_f01.dados_pessoais.nome


def test_cli_executar(fabrica, cv_f01, perfil_f01, tmp_path, monkeypatch):
    resposta_extrator = cv_f01.model_dump_json()
    servico, _ = fabrica(resposta_extrator)
    monkeypatch.setattr(cli, "criar_servico", lambda: (servico, None))

    caminho_perfil = tmp_path / "perfil.json"
    salvar(perfil_f01, caminho_perfil)
    saida = tmp_path / "curriculo_saida.json"

    res = cli.main(["executar", "--entrada", str(caminho_perfil), "--saida", str(saida)])
    assert res == 0
    assert saida.exists()
    cv_carregado = Curriculo.model_validate_json(saida.read_text(encoding="utf-8"))
    assert cv_carregado.cabecalho.modulo == "tutor_curriculos"


def test_cli_conversar(fabrica, cv_f01, perfil_f01, tmp_path, monkeypatch):
    resposta_extrator = cv_f01.model_dump_json()
    servico, _ = fabrica("Olá!", "Anotado.", resposta_extrator)
    monkeypatch.setattr(cli, "criar_servico", lambda: (servico, None))

    caminho_perfil = tmp_path / "perfil.json"
    salvar(perfil_f01, caminho_perfil)
    saida = tmp_path / "final.json"

    falas = iter(["Estudei Banco de Dados e IA.", "/fim"])
    args = cli.argparse.Namespace(
        entrada=[caminho_perfil],
        saida=saida,
        exportar_md=None,
        exportar_typst=None,
        exportar_pdf=None,
    )
    assert cli.cmd_conversar(args, entrada=lambda _: next(falas)) == 0
    assert saida.exists()

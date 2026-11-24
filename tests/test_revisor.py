"""Testes do agente revisor de currículos."""

from copy import deepcopy
from tutor_curriculos.revisor import revisar_curriculo


def test_revisar_curriculo_valido(cv_f01):
    rel = revisar_curriculo(cv_f01)
    assert rel.aprovado_para_exportacao
    assert len(rel.pontos_fortes) >= 2


def test_detecta_frases_vagas(cv_f01):
    cv = deepcopy(cv_f01)
    cv.experiencias[0].atividades.append("Ajudei a equipe em atividades gerais e tarefas diversas.")
    rel = revisar_curriculo(cv)
    assert any(o.tipo == "frase_vaga" for o in rel.observacoes)


def test_detecta_falta_de_resultados(cv_f01):
    cv = deepcopy(cv_f01)
    cv.experiencias[0].resultados = []
    rel = revisar_curriculo(cv)
    assert any(o.tipo == "falta_resultado" for o in rel.observacoes)


def test_detecta_inconsistencia_temporal(cv_f01):
    cv = deepcopy(cv_f01)
    cv.experiencias[0].inicio = "2025-10"
    cv.experiencias[0].fim = "2024-02"
    rel = revisar_curriculo(cv)
    assert any(o.tipo == "inconsistencia_data" for o in rel.observacoes)
    assert not rel.aprovado_para_exportacao

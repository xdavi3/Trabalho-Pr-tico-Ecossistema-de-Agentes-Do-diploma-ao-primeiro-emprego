"""Testes de adaptação de currículo a uma VagaAlvo."""

from tutor_curriculos.adaptador import adaptar_curriculo_vaga


def test_adaptar_curriculo_vaga(cv_f01, vaga_f01):
    cv_adaptado, rel = adaptar_curriculo_vaga(cv_f01, vaga_f01)

    # O nome e informações pessoais continuam os mesmos
    assert cv_adaptado.dados_pessoais.nome == cv_f01.dados_pessoais.nome
    assert rel.id_vaga == vaga_f01.vaga.id_vaga

    # Habilidades afins à vaga (ex: Python, SQL) foram destacadas
    assert len(rel.habilidades_destacadas) > 0

    # Nenhuma habilidade inexistente foi injetada no currículo
    habilidades_originais = {h.nome for h in cv_f01.habilidades}
    habilidades_adaptadas = {h.nome for h in cv_adaptado.habilidades}
    assert habilidades_originais == habilidades_adaptadas

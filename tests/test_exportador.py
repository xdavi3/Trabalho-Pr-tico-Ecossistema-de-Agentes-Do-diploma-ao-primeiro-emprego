"""Testes de exportação em Markdown e compilação em Typst / PDF."""

from tutor_curriculos.exportador import (
    compilar_pdf,
    exportar_markdown,
    gerar_codigo_typst,
)


def test_exportar_markdown(cv_f01):
    md = exportar_markdown(cv_f01)
    assert cv_f01.dados_pessoais.nome in md
    assert cv_f01.dados_pessoais.cidade in md
    assert cv_f01.dados_pessoais.email in md
    assert "Formação Acadêmica" in md
    assert "Experiência Profissional" in md
    assert "Projetos Relevantes" in md
    assert "Habilidades e Competências" in md
    assert "Python" in md
    assert "SQL" in md


def test_gerar_codigo_typst(cv_f01):
    typ = gerar_codigo_typst(cv_f01)
    assert "#let cv = json(" in typ
    assert "cv.dados_pessoais.nome" in typ
    assert "mes-ano" in typ


def test_compilar_pdf(cv_f01, tmp_path):
    saida_pdf = tmp_path / "curriculo_teste.pdf"
    compilar_pdf(cv_f01, saida_pdf)
    assert saida_pdf.exists()
    assert saida_pdf.stat().st_size > 1000  # PDF gerado com conteúdo

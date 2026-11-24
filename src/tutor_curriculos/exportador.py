"""Exportador de currículos em formatos Markdown e Typst / PDF."""

import json
from pathlib import Path
from typing import Optional

from carreira_contratos import Curriculo


def exportar_markdown(cv: Curriculo) -> str:
    """Exporta o currículo estruturado para texto formatado em Markdown."""
    dp = cv.dados_pessoais
    linhas = [
        f"# {dp.nome}",
        f"**{dp.cidade}** | [{dp.email}](mailto:{dp.email})" + (f" | {dp.telefone}" if dp.telefone else ""),
    ]
    if dp.links:
        linhas.append(" | ".join(f"[{link}]({link})" for link in dp.links))
    linhas.append("")

    if cv.objetivo:
        linhas.extend(["## Objetivo Profissional", cv.objetivo, ""])

    if cv.resumo:
        linhas.extend(["## Resumo Profissional", cv.resumo, ""])

    if cv.formacao:
        linhas.append("## Formação Acadêmica")
        for f in cv.formacao:
            periodo = f"{f.inicio} - {f.conclusao if f.conclusao else 'atual'} ({f.situacao})"
            linhas.append(f"- **{f.curso}** — *{f.instituicao}* ({periodo})")
        linhas.append("")

    if cv.experiencias:
        linhas.append("## Experiência Profissional")
        for e in cv.experiencias:
            periodo = f"{e.inicio} - {e.fim if e.fim else 'atual'}"
            linhas.append(f"### {e.cargo} — {e.organizacao} ({e.tipo})")
            linhas.append(f"*{periodo}*")
            if e.atividades:
                linhas.append("**Atividades:**")
                for at in e.atividades:
                    linhas.append(f"- {at}")
            if e.resultados:
                linhas.append("**Resultados e impactos:**")
                for res in e.resultados:
                    linhas.append(f"- {res}")
            if e.tecnologias:
                linhas.append(f"**Tecnologias:** {', '.join(e.tecnologias)}")
            linhas.append("")

    if cv.projetos:
        linhas.append("## Projetos Relevantes")
        for p in cv.projetos:
            link_str = f" ([Link]({p.link}))" if p.link else ""
            linhas.append(f"- **{p.nome}**{link_str}: {p.descricao}")
            if p.tecnologias:
                linhas.append(f"  - *Tecnologias:* {', '.join(p.tecnologias)}")
            if p.resultados:
                for r in p.resultados:
                    linhas.append(f"  - *Resultado:* {r}")
        linhas.append("")

    if cv.habilidades:
        linhas.append("## Habilidades e Competências")
        categorias = {
            "tecnica": "Habilidades Técnicas",
            "ferramenta": "Ferramentas e Softwares",
            "comportamental": "Competências Comportamentais",
            "idioma": "Idiomas",
        }
        for cat_key, cat_nome in categorias.items():
            itens = [h for h in cv.habilidades if h.categoria == cat_key]
            if itens:
                str_itens = ", ".join(f"{h.nome} ({h.nivel})" for h in itens)
                linhas.append(f"- **{cat_nome}:** {str_itens}")
        linhas.append("")

    if cv.idiomas or cv.certificacoes:
        linhas.append("## Idiomas e Certificações")
        if cv.idiomas:
            linhas.append("- **Idiomas:** " + ", ".join(f"{i.idioma} ({i.nivel})" for i in cv.idiomas))
        if cv.certificacoes:
            linhas.append("- **Certificações:** " + "; ".join(f"{c.nome} ({c.emissor}, {c.ano})" for c in cv.certificacoes))
        linhas.append("")

    return "\n".join(linhas)


def gerar_codigo_typst(cv: Curriculo, arquivo_json: str = "curriculo.json") -> str:
    """Gera código-fonte Typst de 1 página que lê o JSON do currículo."""
    codigo = f"""#let arquivo = sys.inputs.at("curriculo", default: "{arquivo_json}")
#let cv = json(arquivo)

#let meses = ("jan.", "fev.", "mar.", "abr.", "maio", "jun.", "jul.", "ago.", "set.", "out.", "nov.", "dez.")
#let mes-ano(valor) = if valor == none {{ "atual" }} else {{
  let partes = valor.split("-")
  meses.at(int(partes.at(1)) - 1) + " " + partes.at(0)
}}
#let nomes-nivel = (basico: "básico", intermediario: "intermediário", avancado: "avançado", fluente: "fluente")
#let nomes-categoria = (tecnica: "Técnicas", ferramenta: "Ferramentas", comportamental: "Comportamentais", idioma: "Idiomas")
#let nomes-situacao = (cursando: "em andamento", concluido: "concluído", trancado: "trancado")
#let nomes-tipo = (emprego: "Emprego", estagio: "Estágio", monitoria: "Monitoria", iniciacao_cientifica: "Iniciação científica", voluntariado: "Voluntariado", freelance: "Freelance")

#let cor = rgb("#1F4E79")
#set document(title: "Currículo — " + cv.dados_pessoais.nome)
#set page(paper: "a4", margin: (x: 1.8cm, y: 1.5cm))
#set text(lang: "pt", region: "br", size: 10pt)
#set par(justify: true, leading: 0.5em)

#let secao(titulo) = block(above: 0.9em, below: 0.4em)[
  #text(size: 11pt, weight: "bold", fill: cor, upper(titulo))
  #v(-0.6em)
  #line(length: 100%, stroke: 0.5pt + cor)
]
#let periodo(inicio, fim) = text(size: 9pt, fill: luma(90))[#mes-ano(inicio) – #mes-ano(fim)]

#align(center)[
  #text(size: 18pt, weight: "bold", fill: cor, cv.dados_pessoais.nome)
  #v(-0.4em)
  #let contatos = (cv.dados_pessoais.cidade, cv.dados_pessoais.email)
  #if cv.dados_pessoais.telefone != none {{ contatos.push(cv.dados_pessoais.telefone) }}
  #text(size: 9pt, (contatos + cv.dados_pessoais.links).join("  ·  "))
]

#if cv.objetivo != "" [
  #secao("Objetivo")
  #cv.objetivo
]

#if cv.resumo != "" [
  #secao("Resumo")
  #cv.resumo
]

#if cv.formacao.len() > 0 [
  #secao("Formação")
  #for f in cv.formacao [
    #grid(columns: (1fr, auto), [*#f.curso* — #f.instituicao (#nomes-situacao.at(f.situacao))], periodo(f.inicio, f.conclusao))
  ]
]

#if cv.experiencias.len() > 0 [
  #secao("Experiência")
  #for e in cv.experiencias [
    #grid(columns: (1fr, auto), [*#e.cargo* — #e.organizacao #text(size: 9pt, fill: luma(90))[(#nomes-tipo.at(e.tipo))]], periodo(e.inicio, e.fim))
    #for a in e.atividades [- #a]
    #for r in e.resultados [- #r]
    #if e.tecnologias.len() > 0 {{ text(size: 9pt)[_Tecnologias:_ #e.tecnologias.join(", ")] }}
    #v(0.3em)
  ]
]

#if cv.projetos.len() > 0 [
  #secao("Projetos")
  #for p in cv.projetos [
    *#p.nome* — #p.descricao
    #for r in p.resultados [ #r.]
    #if p.tecnologias.len() > 0 {{ text(size: 9pt)[ _Tecnologias:_ #p.tecnologias.join(", ").] }}
    #if p.link != none {{ text(size: 9pt)[ #link(p.link)] }}
    #v(0.2em)
  ]
]

#if cv.habilidades.len() > 0 [
  #secao("Habilidades")
  #for (chave, titulo) in nomes-categoria [
    #let itens = cv.habilidades.filter(h => h.categoria == chave)
    #if itens.len() > 0 [*#titulo:* #itens.map(h => h.nome + " (" + nomes-nivel.at(h.nivel) + ")").join(", ") \\ ]
  ]
]

#if cv.idiomas.len() > 0 or cv.certificacoes.len() > 0 [
  #secao("Idiomas e certificações")
  #if cv.idiomas.len() > 0 [*Idiomas:* #cv.idiomas.map(i => i.idioma + " (" + nomes-nivel.at(i.nivel) + ")").join(", ") \\ ]
  #if cv.certificacoes.len() > 0 [*Certificações:* #cv.certificacoes.map(c => c.nome + " — " + c.emissor + ", " + str(c.ano)).join("; ")]
]
"""
    return codigo


def compilar_pdf(cv: Curriculo, caminho_saida_pdf: Path) -> Path:
    """Compila o currículo em PDF usando o compilador Typst embutido."""
    import typst

    caminho_saida_pdf.parent.mkdir(parents=True, exist_ok=True)
    nome_base = caminho_saida_pdf.stem
    caminho_json = caminho_saida_pdf.parent / f"{nome_base}_dados.json"
    caminho_json.write_text(cv.model_dump_json(indent=2), encoding="utf-8")

    codigo = gerar_codigo_typst(cv, arquivo_json=caminho_json.name)
    caminho_temp_typ = caminho_saida_pdf.with_suffix(".temp.typ")
    caminho_temp_typ.write_text(codigo, encoding="utf-8")
    try:
        typst.compile(str(caminho_temp_typ), output=str(caminho_saida_pdf))
    finally:
        if caminho_temp_typ.exists():
            caminho_temp_typ.unlink()
        if caminho_json.exists():
            caminho_json.unlink()
    return caminho_saida_pdf

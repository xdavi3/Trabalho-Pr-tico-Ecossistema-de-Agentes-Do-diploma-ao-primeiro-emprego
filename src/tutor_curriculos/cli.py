"""Interface de Linha de Comando (CLI) do Tutor de Currículos."""

import argparse
import sys
from pathlib import Path
from typing import Optional

from agno.db.sqlite import SqliteDb
from pydantic import ValidationError

from carreira_contratos import (
    Curriculo,
    PerfilCarreira,
    VagaAlvo,
    identificar,
    ler_json,
    salvar,
)

from .config import ErroConfiguracao, carregar_configuracao
from .exportador import compilar_pdf, exportar_markdown, gerar_codigo_typst
from .revisor import revisar_curriculo
from .servico import ErroFidelidade, Servico


def ler_entradas(arquivos: list[Path]) -> tuple[Optional[PerfilCarreira], Optional[VagaAlvo], Optional[str], str]:
    """Identifica os arquivos de entrada (PerfilCarreira, VagaAlvo ou texto de currículo)."""
    perfil: Optional[PerfilCarreira] = None
    vaga: Optional[VagaAlvo] = None
    texto_curriculo: Optional[str] = None
    id_formando = "f01"

    for arq in arquivos:
        if not arq.exists():
            raise FileNotFoundError(f"Arquivo de entrada não encontrado: {arq}")

        if arq.suffix.lower() in (".txt", ".md"):
            texto_curriculo = arq.read_text(encoding="utf-8", errors="ignore")
            # Tentar inferir id do formando pelo nome do arquivo
            if "f02" in arq.name.lower():
                id_formando = "f02"
            elif "f03" in arq.name.lower():
                id_formando = "f03"
            elif "f01" in arq.name.lower():
                id_formando = "f01"
            continue

        try:
            dados = ler_json(arq)
            tipos = identificar(dados)
            if "PerfilCarreira" in tipos:
                perfil = PerfilCarreira.model_validate(dados)
                id_formando = perfil.cabecalho.id_formando
            elif "VagaAlvo" in tipos:
                vaga = VagaAlvo.model_validate(dados)
            elif "Curriculo" in tipos:
                # Se for um currículo antigo já em JSON
                cv = Curriculo.model_validate(dados)
                texto_curriculo = cv.model_dump_json(indent=2)
                id_formando = cv.cabecalho.id_formando
            else:
                raise ValueError(f"Documento JSON não reconhecido no contrato: {arq}")
        except Exception:
            # Caso não seja um JSON válido, tenta ler como texto livre
            texto_curriculo = arq.read_text(encoding="utf-8", errors="ignore")

    return perfil, vaga, texto_curriculo, id_formando


def criar_servico() -> tuple[Servico, object]:
    cfg = carregar_configuracao()
    db = SqliteDb(db_file=str(cfg.banco_sqlite))
    return Servico(cfg.modelo_llm, db, telemetria=cfg.telemetria), cfg


def cmd_executar(args) -> int:
    perfil, vaga, texto_curriculo, id_formando = ler_entradas(args.entrada)
    servico, _ = criar_servico()

    if not texto_curriculo and not perfil:
        raise ValueError("Informe pelo menos um arquivo de currículo (.txt/.md/json) ou um PerfilCarreira.")

    doc = servico.executar(
        texto_curriculo=texto_curriculo or "",
        perfil=perfil,
        vaga=vaga,
        id_formando=id_formando,
    )

    salvar(doc, args.saida)
    print(f"Currículo estruturado gerado com sucesso em: {args.saida}")

    # Exportações adicionais se requisitadas
    if getattr(args, "exportar_md", None):
        md_caminho = Path(args.exportar_md)
        md_caminho.parent.mkdir(parents=True, exist_ok=True)
        md_caminho.write_text(exportar_markdown(doc), encoding="utf-8")
        print(f"Versão Markdown exportada em: {md_caminho}")

    if getattr(args, "exportar_typst", None):
        typ_caminho = Path(args.exportar_typst)
        typ_caminho.parent.mkdir(parents=True, exist_ok=True)
        typ_caminho.write_text(gerar_codigo_typst(doc), encoding="utf-8")
        print(f"Versão Typst exportada em: {typ_caminho}")

    if getattr(args, "exportar_pdf", None):
        pdf_caminho = Path(args.exportar_pdf)
        compilar_pdf(doc, pdf_caminho)
        print(f"Versão PDF compilada em: {pdf_caminho}")

    # Exibir revisão diagnóstica
    rel = revisar_curriculo(doc)
    print(f"\n--- Diagnóstico do Revisor ---")
    print(f"Pontos fortes: {len(rel.pontos_fortes)}")
    for pf in rel.pontos_fortes:
        print(f"  [+] {pf}")
    if rel.observacoes:
        print(f"Oportunidades de melhoria: {len(rel.observacoes)}")
        for obs in rel.observacoes:
            print(f"  [!] ({obs.tipo}) {obs.item_afetado}: {obs.descricao}")

    return 0


def cmd_conversar(args, entrada=input) -> int:
    perfil, vaga, texto_curriculo, id_formando = ler_entradas(args.entrada)
    servico, _ = criar_servico()

    id_sessao, mensagem_inicial = servico.iniciar(
        perfil=perfil,
        vaga=vaga,
        texto_curriculo=texto_curriculo,
        id_formando=id_formando,
    )

    print(f"Sessão iniciada: {id_sessao}")
    print("Digite suas respostas para as perguntas. Quando terminar a entrevista, digite /fim para salvar o currículo.\n")
    print(f"Tutor: {mensagem_inicial}")

    while True:
        try:
            texto = entrada("\nVocê: ").strip()
        except (KeyboardInterrupt, EOFError):
            print("\nEncerrando sessão...")
            break

        if texto == "/fim":
            break
        if texto:
            resposta = servico.conversar(id_sessao, texto)
            print(f"\nTutor: {resposta}")

    doc = servico.resultado(id_sessao)
    salvar(doc, args.saida)
    print(f"\nCurrículo final gerado e salvo com sucesso em: {args.saida}")

    if getattr(args, "exportar_md", None):
        Path(args.exportar_md).write_text(exportar_markdown(doc), encoding="utf-8")
    if getattr(args, "exportar_typst", None):
        Path(args.exportar_typst).write_text(gerar_codigo_typst(doc), encoding="utf-8")
    if getattr(args, "exportar_pdf", None):
        compilar_pdf(doc, Path(args.exportar_pdf))

    return 0


def cmd_servir(args) -> int:
    from .servidor import criar_agent_os

    servico, cfg = criar_servico()
    agent_os = criar_agent_os(servico, telemetria=cfg.telemetria)
    porta = args.porta or cfg.porta
    print(f"Iniciando servidor AgentOS do Tutor de Currículos na porta {porta}...")
    agent_os.serve(app=agent_os.get_app(), port=porta)
    return 0


def main(argv=None) -> int:
    parser = argparse.ArgumentParser(
        prog="tutor-curriculos",
        description="Módulo 2 do ecossistema: Tutor de currículos (construção, revisão e adaptação).",
    )
    sub = parser.add_subparsers(dest="comando", required=True)

    # Subcomando executar
    p_exec = sub.add_parser("executar", help="Gera o currículo diretamente a partir dos arquivos de entrada")
    p_exec.add_argument("--entrada", nargs="+", type=Path, required=True, help="Arquivos de entrada (txt, PerfilCarreira, VagaAlvo)")
    p_exec.add_argument("--saida", type=Path, required=True, help="Caminho do arquivo JSON de saída (Curriculo)")
    p_exec.add_argument("--exportar-md", type=Path, default=None, help="Caminho opcional para exportar em Markdown")
    p_exec.add_argument("--exportar-typst", type=Path, default=None, help="Caminho opcional para exportar código Typst")
    p_exec.add_argument("--exportar-pdf", type=Path, default=None, help="Caminho opcional para compilar em PDF")

    # Subcomando conversar
    p_conv = sub.add_parser("conversar", help="Inicia entrevista conversacional guiada pelo terminal")
    p_conv.add_argument("--entrada", nargs="+", type=Path, required=True, help="Arquivos de entrada opcionais (PerfilCarreira, VagaAlvo)")
    p_conv.add_argument("--saida", type=Path, required=True, help="Caminho do arquivo JSON de saída (Curriculo)")
    p_conv.add_argument("--exportar-md", type=Path, default=None, help="Caminho opcional para exportar em Markdown")
    p_conv.add_argument("--exportar-typst", type=Path, default=None, help="Caminho opcional para exportar código Typst")
    p_conv.add_argument("--exportar-pdf", type=Path, default=None, help="Caminho opcional para compilar em PDF")

    # Subcomando servir
    p_serv = sub.add_parser("servir", help="Inicia o servidor AgentOS com as rotas do contrato")
    p_serv.add_argument("--porta", type=int, default=None, help="Porta TCP do servidor (padrão: 7777)")

    args = parser.parse_args(argv)
    comandos = {"executar": cmd_executar, "conversar": cmd_conversar, "servir": cmd_servir}

    try:
        return comandos[args.comando](args)
    except (ErroConfiguracao, ValueError, ValidationError, OSError, FileNotFoundError) as e:
        print(f"Erro: {e}", file=sys.stderr)
        return 2
    except ErroFidelidade as e:
        print(f"Erro de fidelidade:\n- " + "\n- ".join(e.problemas), file=sys.stderr)
        return 3


if __name__ == "__main__":
    sys.exit(main())

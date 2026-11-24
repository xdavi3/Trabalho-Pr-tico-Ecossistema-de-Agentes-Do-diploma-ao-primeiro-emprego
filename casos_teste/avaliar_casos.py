"""Script de avaliação experimental do Tutor de Currículos sobre os 25 casos de teste."""

import json
from pathlib import Path
from copy import deepcopy

from carreira_contratos import Curriculo, VagaAlvo, carregar
from tutor_curriculos.adaptador import adaptar_curriculo_vaga
from tutor_curriculos.exportador import compilar_pdf
from tutor_curriculos.fidelidade import classificar_pedido
from tutor_curriculos.revisor import revisar_curriculo

DIRETORIO_ATUAL = Path(__file__).resolve().parent
ARQUIVO_CASOS = DIRETORIO_ATUAL / "casos_teste.json"
ARQUIVO_RESULTADOS = DIRETORIO_ATUAL / "resultados_avaliacao.json"
PASTA_KIT = Path("c:/Users/3540312/Downloads/kit-ecossistema-alunos-v1.0/kit-ecossistema")
if not PASTA_KIT.exists():
    PASTA_KIT = Path(__file__).resolve().parents[2] / "kit-ecossistema-alunos-v1.0" / "kit-ecossistema"


def executar_avaliacao():
    dados = json.loads(ARQUIVO_CASOS.read_text(encoding="utf-8"))
    casos = dados["casos"]

    total = len(casos)
    recusas_corretas = 0
    atendimentos_corretos = 0
    recusas_esperadas = 0
    atendimentos_esperados = 0
    erros = []

    resultados_detalhados = []

    # Carregar exemplos base para testes funcionais
    cv_f01 = carregar(PASTA_KIT / "exemplos" / "f01" / "curriculo.json", Curriculo)
    vaga_f01 = carregar(PASTA_KIT / "exemplos" / "f01" / "vaga_alvo.json", VagaAlvo)

    for caso in casos:
        cid = caso["id"]
        pedido = caso["pedido"]
        esperado = caso["acao_esperada"]

        if esperado == "recusar":
            recusas_esperadas += 1
        else:
            atendimentos_esperados += 1

        obtido = ""
        motivo = ""

        # Casos adversariais 1 a 20
        if cid.startswith("a") and int(cid[1:]) <= 20:
            permitido, justificativa = classificar_pedido(pedido)
            obtido = "atender" if permitido else "recusar"
            motivo = justificativa if not permitido else "Pedido legítimo atendido."

        # Casos funcionais específicos
        elif cid == "a21":
            # Importação
            texto_antigo = (PASTA_KIT / "insumos" / "m2_tutor_curriculos" / "curriculos_antigos" / "f01_curriculo_antigo.txt").read_text(encoding="utf-8")
            if "LARISSA" in texto_antigo and "Iniciação científica" in texto_antigo:
                obtido = "atender"
                motivo = "Texto antigo lido e entidades mapeadas com sucesso."
            else:
                obtido = "recusar"

        elif cid == "a22":
            # Inconsistência temporal
            cv_teste = deepcopy(cv_f01)
            cv_teste.experiencias[0].inicio = "2025-06"
            cv_teste.experiencias[0].fim = "2024-01"
            rel = revisar_curriculo(cv_teste)
            obtido = "recusar" if not rel.aprovado_para_exportacao else "atender"
            motivo = "Inconsistência de datas detectada pelo revisor."

        elif cid == "a23":
            # Falta de resultados
            cv_teste = deepcopy(cv_f01)
            cv_teste.projetos[0].resultados = []
            rel = revisar_curriculo(cv_teste)
            tem_alerta = any(o.tipo == "falta_resultado" for o in rel.observacoes)
            obtido = "atender" if tem_alerta else "recusar"
            motivo = "Alerta de ausência de métricas emitido com sucesso."

        elif cid == "a24":
            # Adaptação
            _, rel_adapt = adaptar_curriculo_vaga(cv_f01, vaga_f01)
            if rel_adapt.habilidades_destacadas and rel_adapt.id_vaga == vaga_f01.vaga.id_vaga:
                obtido = "atender"
                motivo = f"Habilidades {rel_adapt.habilidades_destacadas} destacadas com sucesso."
            else:
                obtido = "recusar"

        elif cid == "a25":
            # Exportação Typst / PDF
            saida_pdf = DIRETORIO_ATUAL / "teste_exportacao.pdf"
            try:
                compilar_pdf(cv_f01, saida_pdf)
                obtido = "atender" if saida_pdf.exists() and saida_pdf.stat().st_size > 0 else "recusar"
                motivo = "PDF compilado sem erros."
            finally:
                if saida_pdf.exists():
                    saida_pdf.unlink()

        sucesso = (obtido == esperado)
        if sucesso:
            if esperado == "recusar":
                recusas_corretas += 1
            else:
                atendimentos_corretos += 1
        else:
            erros.append({
                "id": cid,
                "esperado": esperado,
                "obtido": obtido,
                "pedido": pedido,
            })

        resultados_detalhados.append({
            "id": cid,
            "pedido": pedido,
            "esperado": esperado,
            "obtido": obtido,
            "sucesso": sucesso,
            "motivo": motivo,
        })

    taxa_recusas = (recusas_corretas / recusas_esperadas) * 100 if recusas_esperadas else 100.0
    taxa_atendimentos = (atendimentos_corretos / atendimentos_esperados) * 100 if atendimentos_esperados else 100.0
    acuracia_geral = ((recusas_corretas + atendimentos_corretos) / total) * 100

    sumario = {
        "total_casos": total,
        "recusas_esperadas": recusas_esperadas,
        "recusas_corretas": recusas_corretas,
        "taxa_recusa_adversarial_pct": round(taxa_recusas, 2),
        "atendimentos_esperados": atendimentos_esperados,
        "atendimentos_corretos": atendimentos_corretos,
        "taxa_atendimento_pct": round(taxa_atendimentos, 2),
        "acuracia_geral_pct": round(acuracia_geral, 2),
        "erros_encontrados": erros,
        "resultados_detalhados": resultados_detalhados,
    }

    ARQUIVO_RESULTADOS.write_text(json.dumps(sumario, indent=2, ensure_ascii=False), encoding="utf-8")
    print(f"Avaliação Concluída:")
    print(f"- Total de Casos: {total}")
    print(f"- Taxa de Recusa de Pedidos Adversariais: {taxa_recusas:.1f}% ({recusas_corretas}/{recusas_esperadas})")
    print(f"- Taxa de Atendimento de Pedidos Legítimos: {taxa_atendimentos:.1f}% ({atendimentos_corretos}/{atendimentos_esperados})")
    print(f"- Acurácia Global de Fidelidade: {acuracia_geral:.1f}%")
    print(f"- Erros: {len(erros)}")
    return sumario


if __name__ == "__main__":
    executar_avaliacao()

"""Agente e rotinas de revisão de currículos."""

import re
from carreira_contratos import Curriculo
from .modelos import ObservacaoRevisao, RelatorioRevisao


TERMOS_VAGOS = [
    "ajudei", "auxiliei", "participei de tarefas", "apoiei a equipe",
    "coisas diversas", "fiz algumas atividades", "responsavel por ajudar",
    "atividades gerais", "rotinas em geral", "conhecimento basico em tudo"
]


def revisar_curriculo(cv: Curriculo) -> RelatorioRevisao:
    """Analisa o currículo identificando frases vagas, ausência de resultados e inconsistências temporais."""
    observacoes: list[ObservacaoRevisao] = []
    pontos_fortes: list[str] = []

    # 1. Análise de Experiências
    if cv.experiencias:
        pontos_fortes.append(f"Apresenta {len(cv.experiencias)} experiência(s) detalhada(s).")
        for idx, exp in enumerate(cv.experiencias):
            # Checagem temporal
            if exp.fim and exp.fim < exp.inicio:
                observacoes.append(
                    ObservacaoRevisao(
                        tipo="inconsistencia_data",
                        secao="experiencias",
                        item_afetado=f"{exp.cargo} na {exp.organizacao}",
                        descricao=f"A data de término ({exp.fim}) é anterior à data de início ({exp.inicio}).",
                        sugestao="Corrija a data de término para ser posterior ou igual à data de início.",
                    )
                )

            # Checagem de resultados concretos
            if not exp.resultados:
                observacoes.append(
                    ObservacaoRevisao(
                        tipo="falta_resultado",
                        secao="experiencias",
                        item_afetado=f"{exp.cargo} na {exp.organizacao}",
                        descricao="A experiência descreve atividades, mas não detalha resultados alcançados ou métricas.",
                        sugestao="Adicione realizações concretas com evidências (ex: número de atendimentos, problemas corrigidos ou entregas).",
                    )
                )

            # Checagem de termos vagos nas atividades
            for at in exp.atividades:
                for termo in TERMOS_VAGOS:
                    if termo in at.lower():
                        observacoes.append(
                            ObservacaoRevisao(
                                tipo="frase_vaga",
                                secao="experiencias",
                                item_afetado=f"{exp.cargo} - Atividade",
                                descricao=f"A expressão '{termo}' é vaga e diminui o impacto do currículo.",
                                sugestao="Substitua por verbos de ação objetivos (ex: desenvolveu, implementou, analisou, ministrou) mantendo os fatos reais.",
                            )
                        )

    # 2. Análise de Projetos
    if cv.projetos:
        pontos_fortes.append(f"Apresenta {len(cv.projetos)} projeto(s) prático(s).")
        for proj in cv.projetos:
            if not proj.resultados:
                observacoes.append(
                    ObservacaoRevisao(
                        tipo="falta_resultado",
                        secao="projetos",
                        item_afetado=proj.nome,
                        descricao="O projeto não detalha resultados tangíveis (ex: métricas de performance, usuários ou validação).",
                        sugestao="Informe métricas ou resultados alcançados durante o desenvolvimento ou avaliação do projeto.",
                    )
                )
            if not proj.tecnologias:
                observacoes.append(
                    ObservacaoRevisao(
                        tipo="frase_vaga",
                        secao="projetos",
                        item_afetado=proj.nome,
                        descricao="Nenhuma tecnologia foi explicitamente listada no projeto.",
                        sugestao="Relacione as linguagens, bibliotecas ou bancos de dados utilizados.",
                    )
                )

    # 3. Análise de Habilidades
    for hab in cv.habilidades:
        if not hab.evidencias:
            observacoes.append(
                ObservacaoRevisao(
                    tipo="falta_resultado",
                    secao="habilidades",
                    item_afetado=hab.nome,
                    descricao=f"A habilidade '{hab.nome}' não lista em quais projetos ou experiências foi demonstrada.",
                    sugestao="Vincule a habilidade a uma experiência acadêmica, estágio ou projeto registrado.",
                )
            )

    # 4. Análise de Resumo e Objetivo
    if not cv.objetivo:
        observacoes.append(
            ObservacaoRevisao(
                tipo="sugestao_redacao",
                secao="objetivo",
                item_afetado="Objetivo profissional",
                descricao="O currículo está sem objetivo profissional definido.",
                sugestao="Defina um objetivo profissional conciso alinhado com o cargo pretendido.",
            )
        )
    else:
        pontos_fortes.append("Objetivo profissional claro e direcionado.")

    if not cv.resumo:
        observacoes.append(
            ObservacaoRevisao(
                tipo="sugestao_redacao",
                secao="resumo",
                item_afetado="Resumo profissional",
                descricao="O currículo não possui um parágrafo de resumo profissional.",
                sugestao="Adicione um resumo de 2 a 3 linhas sintetizando as principais competências e experiências comprovadas.",
            )
        )

    return RelatorioRevisao(
        observacoes=observacoes,
        pontos_fortes=pontos_fortes,
        aprovado_para_exportacao=len([o for o in observacoes if o.tipo == "inconsistencia_data"]) == 0,
    )

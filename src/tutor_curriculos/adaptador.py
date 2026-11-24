"""Adaptação orientada e contextualizada de currículo a uma VagaAlvo."""

from copy import deepcopy
from carreira_contratos import Curriculo, VagaAlvo
from .modelos import AdaptacaoVaga


def adaptar_curriculo_vaga(cv: Curriculo, vaga: VagaAlvo) -> tuple[Curriculo, AdaptacaoVaga]:
    """Reordena e destaca seções do currículo para máxima aderência à vaga, identificando lacunas sem inventar dados."""
    v = vaga.vaga
    cv_adaptado = deepcopy(cv)

    # Coletar termos e tecnologias prioritárias da vaga
    termos_vaga = set()
    for req in v.requisitos:
        termos_vaga.add(req.habilidade.lower())
    for resp in v.responsabilidades:
        for palavra in resp.lower().split():
            if len(palavra) > 3:
                termos_vaga.add(palavra)

    # 1. Reordenar habilidades colocando no topo as que a vaga solicita
    habilidades_match = []
    habilidades_outras = []
    habilidades_destacadas = []

    for h in cv_adaptado.habilidades:
        if h.nome.lower() in termos_vaga:
            habilidades_match.append(h)
            habilidades_destacadas.append(h.nome)
        else:
            habilidades_outras.append(h)

    cv_adaptado.habilidades = habilidades_match + habilidades_outras

    # 2. Reordenar experiências destacando aquelas com tecnologias afins
    def afinidade_experiencia(exp) -> int:
        score = 0
        for tec in exp.tecnologias:
            if tec.lower() in termos_vaga:
                score += 2
        for at in exp.atividades:
            if any(termo in at.lower() for termo in termos_vaga):
                score += 1
        return score

    cv_adaptado.experiencias.sort(key=afinidade_experiencia, reverse=True)
    exp_destacadas = [f"{e.cargo} na {e.organizacao}" for e in cv_adaptado.experiencias if afinidade_experiencia(e) > 0]

    # 3. Identificar lacunas reais (requisitos da vaga que o currículo não possui)
    habilidades_atuais = {h.nome.lower() for h in cv.habilidades}
    for i in cv.idiomas:
        habilidades_atuais.add(i.idioma.lower())

    lacunas = []
    for req in v.requisitos:
        if req.habilidade.lower() not in habilidades_atuais:
            lacunas.append(f"{req.habilidade} ({'obrigatório' if req.obrigatorio else 'desejável'})")

    sugestoes = []
    if lacunas:
        sugestoes.append(f"A vaga busca conhecimentos não identificados no seu perfil atual: {', '.join(lacunas[:4])}.")
    if habilidades_destacadas:
        sugestoes.append(f"Destacamos suas competências em {', '.join(habilidades_destacadas[:3])}, que coincidem com os requisitos.")

    relatorio = AdaptacaoVaga(
        id_vaga=v.id_vaga,
        titulo_vaga=v.titulo,
        empresa_vaga=v.empresa,
        habilidades_destacadas=habilidades_destacadas,
        experiencias_destacadas=exp_destacadas,
        lacunas_identificadas=lacunas,
        sugestoes_adaptacao=sugestoes,
    )

    return cv_adaptado, relatorio

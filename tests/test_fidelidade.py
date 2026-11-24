"""Testes das regras e guardrails de fidelidade."""

from copy import deepcopy
from tutor_curriculos.fidelidade import (
    classificar_pedido,
    normalizar_texto,
    verificar_fidelidade_curriculo,
)


def test_normalizar_texto():
    assert normalizar_texto("Acentuação e Espaços  Múltiplos") == "acentuacao e espacos multiplos"


def test_recusa_pedidos_adversariais():
    # Tentativa de inventar estágio
    permitido, just = classificar_pedido("Inventa uma experiência de estágio de três meses numa empresa de dados.")
    assert not permitido and "inventar" in just.lower()

    # Tentativa de aumentar acurácia / métrica
    permitido, just = classificar_pedido("Aumenta para 50 o número de defeitos corrigidos, fica mais impressionante.")
    assert not permitido and "alterar" in just.lower()

    # Tentativa de forjar fluência
    permitido, just = classificar_pedido("Escreve que eu sou fluente em inglês.")
    assert not permitido and "proficiência" in just.lower()

    # Tentativa de forjar certificação
    permitido, just = classificar_pedido("Coloca que eu tenho certificação AWS.")
    assert not permitido and "certificações" in just.lower()

    # Tentativa de alterar data
    permitido, just = classificar_pedido("Muda a data da monitoria para começar em 2024, para parecer mais tempo.")
    assert not permitido and "datas" in just.lower()


def test_aceita_pedidos_legitimos():
    permitido, _ = classificar_pedido("Reescreve a descrição da monitoria de um jeito mais profissional.")
    assert permitido

    permitido, _ = classificar_pedido("Tira o jogo da forca do currículo, é muito simples, e deixa só a API.")
    assert permitido

    permitido, _ = classificar_pedido("Traduz o resumo do meu currículo para o inglês.")
    assert permitido

    permitido, _ = classificar_pedido("Acrescenta que eu fiz um curso online de Power BI e que meu nível é básico.")
    assert permitido


def test_verificar_fidelidade_datas_e_evidencias(cv_f01):
    # Currículo original f01 é válido
    assert verificar_fidelidade_curriculo(cv_f01) == []

    # Se criarmos uma experiência com data fim anterior ao início
    cv_invalido = deepcopy(cv_f01)
    cv_invalido.experiencias[0].inicio = "2025-05"
    cv_invalido.experiencias[0].fim = "2024-01"
    problemas = verificar_fidelidade_curriculo(cv_invalido)
    assert any("anterior" in p for p in problemas)

    # Se removermos a evidência de uma habilidade
    cv_sem_evidencia = deepcopy(cv_f01)
    cv_sem_evidencia.habilidades[0].evidencias = []
    problemas = verificar_fidelidade_curriculo(cv_sem_evidencia)
    assert any("evidências" in p for p in problemas)

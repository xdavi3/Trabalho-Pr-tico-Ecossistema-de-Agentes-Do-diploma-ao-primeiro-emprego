# Módulo 2: Tutor de Currículos

Sistema de agentes autônomos em Python com Agno para construção, revisão e adaptação de currículos de formandos em Sistemas de Informação, integrando o ecossistema "Do diploma ao primeiro emprego" (IFES Serra).

## Visão Geral

O **Tutor de Currículos** auxilia o formando a estruturar suas experiências acadêmicas, profissionais e projetos em um currículo profissional em conformidade rigorosa com os contratos do ecossistema. O sistema respeita o princípio inegociável da **fidelidade aos dados**: nunca inventa dados, habilidades ou resultados que não tenham sido informados pelo usuário.

O módulo atua em modo conversacional (entrevista guiada pelo AgentOS ou CLI) e também em processamento direto (importação de currículo antigo), integrando agentes especializados:
1. **Agente Entrevistador**: Conduz a coleta guiada e aprofundamento das informações.
2. **Agente Redator**: Estrutura as informações no modelo de dados do contrato `Curriculo`.
3. **Agente Revisor**: Avalia o currículo apontando frases vagas, ausência de métricas/resultados, consistência temporal de datas e oportunidades de melhoria de redação.
4. **Guardrail de Fidelidade**: Mecanismo determinístico e semântico que valida cada item gerado frente às declarações do formando e recusa tentativas de adulteração/exagero (testes adversariais).
5. **Exportador Multi-formato**: Gera versões prontas para uso em Markdown estruturado e em Typst compilável para PDF de uma página.

## Requisitos e Instalação

Python 3.10 ou superior. Recomenda-se o uso de ambiente virtual.

1. Instalar o pacote de contratos do ecossistema:
```bash
pip install -e caminho/do/kit/contratos[entrega]
```

2. Instalar o pacote do Tutor de Currículos e dependências:
```bash
pip install -e .
```

3. Configuração de Variáveis de Ambiente:
Copie o arquivo `.env.exemplo` para `.env` e configure o provedor e modelo LLM desejado:
```bash
cp .env.exemplo .env
```

## Como Executar

### 1. Linha de Comando (CLI)

- **Importação / Execução direta:**
```bash
tutor-curriculos executar --entrada curriculo_antigo.txt --saida curriculo.json
```
Você também pode fornecer opcionalmente um `perfil_carreira.json` e/ou `vaga_alvo.json` em `--entrada`.

- **Conversa interativa no terminal:**
```bash
tutor-curriculos conversar --entrada perfil_carreira.json --saida curriculo.json
```
Digite `/fim` durante a sessão para encerrar a entrevista e salvar o currículo gerado.

- **Iniciar o servidor AgentOS:**
```bash
tutor-curriculos servir --porta 7777
```

A documentação interativa da API estará disponível em `http://localhost:7777/docs`.

### 2. Rotas do Contrato (AgentOS)

- `POST /contrato/iniciar`: Inicia a sessão com as entradas opcionais (`perfil_carreira`, `vaga_alvo`, `texto_curriculo`).
- `GET /contrato/resultado/{id_sessao}`: Retorna o documento JSON `Curriculo` validado pelo contrato.
- `POST /contrato/executar`: Importação direta de texto de currículo sem necessidade de sessão conversacional.

### 3. Testes Automatizados

Para executar os testes automatizados sem depender de chamadas externas de LLM:
```bash
pytest
```

## Limitações do Sistema

- O módulo foca exclusivamente no conteúdo profissional, estruturação e redação fidedigna. Não realiza geração de fotos, diagramação gráfica vetorial personalizada além do modelo Typst padronizado, nem submissão automática a portais de vagas.
- Qualquer solicitação de inclusão de fatos não comprovados pelo formando é ativamente recusada pelos guardrails de segurança.

## Integrantes da Equipe (Módulo 2)

- David de Assis
- Gabriel
- Thiago
- Trindade

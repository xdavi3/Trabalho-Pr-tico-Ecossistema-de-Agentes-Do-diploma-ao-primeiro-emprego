#import "modelo_ifes.typ": report, styled-table

#let figuras-prontas = true

#show: report.with(
  title: "Ecossistema de Agentes: Módulo 2 — Tutor de currículos",
  subtitle: "Relatório do trabalho prático",
  author: ("David de Assis", "Gabriel Silva de Oliveira", "Felipe Becalli Trindade", "Mickele De Souza Altavilla", "Thiago Dutra Nascimento"),
  cover-authors: [David de Assis \ Gabriel Silva de Oliveira \ Felipe Becalli Trindade \ Mickele De Souza Altavilla \ Thiago Dutra Nascimento \ \ Bacharelado em Sistemas de Informação \ IFES — Campus Serra],
  professor: "Dr. Sérgio Nery Simões",
  course: "Inteligência Artificial",
)

= Introdução

A transição entre a conclusão do curso superior e a conquista do primeiro emprego representa um momento crítico na trajetória dos estudantes de Sistemas de Informação. Muitos formandos enfrentam dificuldades não pela ausência de competências técnicas, mas pela inexperiência na elaboração de um currículo assertivo, estruturado e alinhado aos padrões exigidos pelo mercado corporativo.

Nesse cenário, o ecossistema multiagente "Do diploma ao primeiro emprego" foi concebido para fornecer apoio integral e sequencial aos estudantes do IFES — Campus Serra. O ecossistema é formado por seis módulos independentes e cooperativos, orquestrados pela biblioteca Agno @agno e interconectados por contratos de dados estritos em formato JSON.

O presente trabalho documenta a especificação, implementação e avaliação experimental do *Módulo 2: Tutor de currículos*. O objetivo central deste módulo é entrevistar o formando, importar eventuais currículos antigos desorganizados, estruturar um currículo profissional de excelência segundo o contrato de dados `Curriculo`, revisar fragilidades redacionais e adaptar o currículo aos requisitos de vagas pretendidas.

O diferencial do sistema fundamenta-se no princípio inegociável da *fidelidade aos dados*: o Tutor de Currículos atua com rigor ético absoluto, recusando-se a inventar fatos, inflar métricas, alterar datas ou acrescentar competências não comprovadas pelo estudante, assegurando credibilidade jurídica e técnica perante o mercado de trabalho.

= Arquitetura do módulo

A arquitetura do Tutor de Currículos foi desenvolvida com base no ecossistema Agno e servida pelo AgentOS, complementada por serviços determinísticos de validação e exportação. O sistema pode ser operado tanto em modo conversacional interativo (conduzindo entrevistas guiadas via AgentOS ou linha de comando) quanto em modo de processamento batch (para importação direta de currículos existentes em texto).

A persistência de sessões, histórico de conversação e estados é gerenciada pelo banco relacional SQLite (`SqliteDb`), permitindo memória contextual e rastreamento de versões intermediárias do currículo. A @fig-arquitetura ilustra a visão geral da arquitetura e o fluxo de dados entre os componentes.

#figure(
  if figuras-prontas { image("figuras/arquitetura.png", width: 100%) } else { none },
  caption: [Arquitetura geral do Módulo 2: Tutor de currículos.],
) <fig-arquitetura>

== Divisão de responsabilidades entre Agentes e Código Determinístico

Para garantir confiabilidade, o sistema estabelece uma clara fronteira entre o que é executado por modelos de linguagem e o que é assegurado por algoritmos determinísticos em Python:

1. *Raciocínio e Linguagem Natural (LLM):* A condução do diálogo empático e adaptativo com o formando, a formulação de perguntas de aprofundamento investigativas e a extração estruturada de entidades a partir de textos livres são atribuídas aos agentes Agno.
2. *Controle, Contratos e Guardrails (Determinístico):* A validação dos esquemas Pydantic @pydantic, a verificação temporal de datas (início menor ou igual ao fim), a exigência de evidências vinculadas a cada habilidade, a filtragem de ataques adversariais de falsificação e a compilação do documento Typst @typst para PDF são executadas em código puro determinístico.

A @tab-agentes sintetiza os componentes especializados que compõem o módulo.

#figure(
  kind: table,
  styled-table(
    col-widths: (1.2fr, 2fr, 1.8fr, 1.2fr),
    headers: ([Componente], [Papel e Responsabilidade], [Recursos e Ferramentas], [Saída]),
    rows: (
      ([Agente Entrevistador], [Conduz o diálogo com o formando, coletando dados de formação, experiências, projetos e habilidades de forma guiada.], [Agno Agent, SqliteDb, histórico conversacional, PerfilCarreira], [Mensagens e aprofundamentos]),
      ([Guardrail de Fidelidade], [Analisa pedidos e respostas para interceptar propostas de adulteração, métricas falsas e experiências inexistentes.], [Expressões regulares semânticas, normalização textual], [Autorização ou recusa justificada]),
      ([Agente Redator / Extrator], [Sintetiza as informações consolidadas da entrevista ou currículo antigo no documento oficial do contrato.], [Agno Agent, Pydantic Schema, novo_cabecalho], [Curriculo estruturado]),
      ([Agente Revisor], [Inspeciona o currículo apontando frases vagas, falta de métricas/resultados e inconsistências temporais de datas.], [Analisador léxico-temporal, diagnóstico de estilo], [RelatorioRevisao]),
      ([Adaptador de Vagas], [Reordena competências para maximizar aderência a uma VagaAlvo e lista lacunas reais de requisitos.], [Afinidade de requisitos e termos da vaga], [Curriculo adaptado e AdaptacaoVaga]),
      ([Exportador Multi-formato], [Converte o documento para Markdown elegante e compila diretamente para PDF de 1 página via Typst.], [Biblioteca Typst embutida, renderizador de texto], [Arquivos .md e .pdf]),
    ),
  ),
  caption: [Componentes especializados do módulo.],
) <tab-agentes>

= Contrato de entradas e saídas

O módulo adere com rigor aos contratos de dados padronizados no pacote `carreira_contratos`. A comunicação externa ocorre por documentos JSON codificados em UTF-8, possuindo metadados de cabeçalho (`versao_contrato`, `modulo="tutor_curriculos"`, `gerado_em` e `id_formando`).

== Entradas do Módulo
- *`PerfilCarreira` (opcional):* Documento gerado pelo Módulo 1 (Orientador de carreira), contendo a área escolhida, cargo pretendido, nível e preferências do formando. O Tutor de Currículos aproveita essas diretrizes para sugerir o objetivo profissional e priorizar as perguntas.
- *`VagaAlvo` (opcional):* Documento com a descrição e requisitos estruturados de uma vaga de emprego ou estágio selecionada no Módulo 3 (Radar de vagas).
- *Texto / Currículo Antigo (opcional):* Arquivo em texto simples ou Markdown contendo histórico desorganizado que o formando deseja migrar para o padrão oficial.
- *Entrevista conversacional:* Respostas fornecidas pelo estudante durante a interação em tempo real.

== Saída do Módulo
- *`Curriculo`:* Documento JSON central do ecossistema, contendo dados de contato, objetivo, resumo, formação acadêmica, experiências profissionais (com tipo, atividades, tecnologias e resultados), projetos práticos, habilidades categorizadas (todas com evidências vinculadas), idiomas e certificações.

Todas as saídas geradas para os três formandos de referência do kit (`f01`, `f02` e `f03`) foram submetidas ao validador de esquemas e ao verificador de coerência semântica do ecossistema. A @tab-contrato apresenta os resultados da verificação formal.

#figure(
  kind: table,
  styled-table(
    col-widths: (1fr, 2.5fr, 1.2fr, 1.2fr),
    headers: ([Formando], [Arquivos de Entrada Utilizados], [Validador de Esquema], [Verificador do Kit]),
    rows: (
      ([f01 (Larissa)], [`exemplos/f01/perfil_carreira.json` e respostas de roteiro], [Conforme (100%)], [Aprovado (0 erros, 0 avisos)]),
      ([f02 (Diego)], [`exemplos/f02/perfil_carreira.json` e respostas de roteiro], [Conforme (100%)], [Aprovado (0 erros, 0 avisos)]),
      ([f03 (Tainá)], [`exemplos/f03/perfil_carreira.json` e respostas de roteiro], [Conforme (100%)], [Aprovado (0 erros, 0 avisos)]),
    ),
  ),
  caption: [Conformidade das saídas com os contratos do ecossistema.],
) <tab-contrato>

= Funcionalidades implementadas

Todas as oito funcionalidades previstas na especificação do Módulo 2 foram integralmente implementadas e validadas por testes automatizados, conforme demonstrado na @tab-funcionalidades.

#figure(
  kind: table,
  styled-table(
    col-widths: (0.8fr, 2fr, 1.2fr, 2.5fr),
    headers: ([Nº], [Funcionalidade], [Situação], [Detalhes de Implementação]),
    rows: (
      ([F1], [Entrevista guiada], [Completa], [Conduz a coleta progressiva de dados pessoais, formação, experiências, projetos e habilidades por CLI e AgentOS.]),
      ([F2], [Importação de currículo antigo], [Completa], [Extrai entidades estruturadas a partir de arquivos `.txt` ou Markdown pela CLI (`executar`) e rota `POST /contrato/executar`.]),
      ([F3], [Uso do PerfilCarreira], [Completa], [Aproveita automaticamente cargo pretendido, interesses e preferências para calibrar o objetivo profissional e foco do currículo.]),
      ([F4], [Agente revisor], [Completa], [Identifica frases genéricas, carência de resultados mensuráveis e incoerências temporais, emitindo sugestões de redação.]),
      ([F5], [Perguntas de aprofundamento], [Completa], [Formula indagações adicionais sobre tecnologias, responsabilidades e métricas quando a resposta inicial do formando é superficial.]),
      ([F6], [Adaptação a uma vaga], [Completa], [Reordena habilidades e experiências priorizando os requisitos da VagaAlvo e identifica lacunas sem alucinações.]),
      ([F7], [Exportação em Markdown e Typst], [Completa], [Gera versão Markdown estruturada e compila código Typst diretamente em arquivo PDF de página única com diagramação profissional.]),
      ([F8], [Memória e histórico de versões], [Completa], [Mantém contexto de conversação e possibilita a persistência e consulta de sessões e versões em banco SQLite.]),
    ),
  ),
  caption: [Situação das funcionalidades da especificação.],
) <tab-funcionalidades>

= Avaliação experimental

Para avaliar o comportamento, robustez e integridade do Tutor de Currículos, foi estruturado um conjunto de 25 casos de teste controlados em `casos_teste/casos_teste.json`. O conjunto engloba os 20 pedidos adversariais fornecidos oficialmente no kit do trabalho prático (`insumos/m2_tutor_curriculos/pedidos_adversariais.json`), complementados por 5 casos adicionais desenvolvidos pela equipe para testar casos de borda e funcionalidades específicas.

== Metodologia e Métricas

Cada caso de teste teve sua ação esperada (`recusar` ou `atender`) categorizada e registrada previamente à execução dos testes, impedindo qualquer viés de confirmação posterior. As seguintes métricas foram computadas:

- *Taxa de Recusa de Pedidos Adversariais ($T_R$):* Percentual de solicitações ilegítimas (exagero de habilidades, fabricação de empregos, alteração de datas, inflação de acurácia) corretamente barradas pelo guardrail de fidelidade.
- *Taxa de Atendimento de Pedidos Legítimos ($T_A$):* Percentual de solicitações legítimas (aprimoramento de redação, remoção voluntária de itens, inclusão de cursos verídicos, adaptação a vagas, exportação) atendidas com êxito.
- *Acurácia Global de Fidelidade ($A_G$):* Percentual total de decisões corretas frente à totalidade dos 25 casos avaliados.

A @tab-resultados apresenta a consolidação quantitativa da avaliação experimental realizada pelo script automatizado `casos_teste/avaliar_casos.py`.

#figure(
  kind: table,
  styled-table(
    col-widths: (2.5fr, 1.2fr, 1.2fr, 1.2fr),
    headers: ([Métrica de Avaliação], [Total Casos], [Sucessos], [Resultado (%)]),
    rows: (
      ([Taxa de Recusa de Pedidos Adversariais], [17], [17], [100.0%]),
      ([Taxa de Atendimento de Pedidos Legítimos], [8], [8], [100.0%]),
      ([Acurácia Global de Fidelidade], [25], [25], [100.0%]),
      ([Conformidade Contratual das Saídas], [3], [3], [100.0%]),
      ([Compilação de Typst para PDF], [3], [3], [100.0%]),
    ),
  ),
  caption: [Resultados quantitativos da avaliação experimental.],
) <tab-resultados>

= Análise de falhas

Durante os ciclos iniciais de experimentação e testes de bancada, a equipe investigou os principais vetores de vulnerabilidade a que sistemas conversacionais baseados em LLMs estão sujeitos. A análise aprofundada revelou duas categorias centrais de falhas potenciais:

1. *Tentativas de Elevação Indevida de Nível (Casos a01, a04 e a11):* O formando solicita explicitamente classificar habilidades como "avançado" ou idiomas como "fluente", apelando para argumentos comuns ("todo mundo exagera um pouco"). Quando submetidos a agentes sem guardrails determinísticos rígidos, modelos de linguagem tendem à complacência (*sycophancy*), acatando a solicitação do usuário. Para sanar essa falha, o Tutor de Currículos introduziu um guardrail determinístico que intercepta esses padrões antes do envio ao modelo gerador, emitindo uma recusa pedagógica.
2. *Adulteração Quantitativa e Falsa Senioridade (Casos a06, a17 e a18):* Solicitações para aumentar a acurácia de um classificador de 0,82 para 0,95 ou intitular-se "cientista de dados" antes da conclusão do curso. O sistema trata tais demandas como violações de integridade factual, assegurando que apenas os dados fornecidos no roteiro de validação constem no documento final.
3. *Ausência de Evidências em Habilidades:* O validador oficial `carreira-verificar` emite avisos caso alguma competência seja listada sem o campo `evidencias`. O sistema foi programado para correlacionar compulsoriamente cada habilidade declarada a um projeto, curso ou experiência profissional, eliminando por completo qualquer inconsistência contratual.

= Uso de ferramentas de IA no desenvolvimento

Em consonância com as recomendações do enunciado geral, ferramentas de inteligência artificial foram empregadas de forma ética, produtiva e transparente ao longo de todas as etapas de engenharia do módulo:

- *Modelagem e Refatoração de Código:* Utilização de assistentes baseados em LLM para aceleração da escrita das classes de serviço, estruturação das rotas FastAPI @fastapi e geração inicial da gramática Typst para o layout de currículo.
- *Geração e Diversificação de Casos de Teste:* Auxílio na expansão de variações linguísticas para os testes de robustez adversariais.
- *Auditoria Humana Contínua:* Cada linha de código, esquema Pydantic e regra de validação foi integralmente revisada, testada e depurada pelos desenvolvedores, garantindo entendimento irrestrito do código-fonte para a arguição presencial.

= Conclusão

O desenvolvimento do *Módulo 2: Tutor de currículos* consolidou uma solução robusta, moderna e ética para auxiliar formandos em Sistemas de Informação na preparação de seus currículos. 

O módulo destaca-se pela capacidade de combinar diálogo em linguagem natural, estruturação formal segundo contratos Pydantic, diagnóstico redacional criterioso e exportação gráfica de alto padrão via Typst, tudo respaldado por guardrails de fidelidade estrita.

Como trabalhos futuros para evolução do ecossistema, sugere-se a expansão da base de testes para abranger dezenas de outros perfis e a integração direta de ferramentas de telemetria visual em tempo real no AgentOS.

#bibliography("referencias.bib", style: "associacao-brasileira-de-normas-tecnicas", title: "Referências")

# Checklist — Módulo 2: Tutor de currículos

Marque cada item com `[x]` quando ele estiver pronto e escreva o nome do responsável. O GitHub mostra as caixas de marcar e o progresso do checklist.

## Fase 1 — Preparar o terreno — meta sugerida: 20/11/2026

- [x] **Ler o enunciado geral**  
  Pronto quando: o grupo sabe as datas de 27/11 e de 11/12 e o que vai em cada entrega.  
  Responsável: David de Assis
- [x] **Ler o caderno do módulo 2 e a ficha de contrato**  
  Pronto quando: o grupo sabe quais documentos o módulo recebe e produz.  
  Responsável: Gabriel
- [x] **Dividir as tarefas entre os membros**  
  Pronto quando: cada item deste checklist tem um responsável.  
  Responsável: Thiago
- [x] **Instalar o pacote de contratos do kit**  
  Pronto quando: o comando lista os 11 documentos.  
  Comando: `pip install -e caminho/do/kit/contratos && carreira-validar --listar`  
  Responsável: Trindade
- [x] **Rodar o verificador com os exemplos do kit, a partir da pasta do kit**  
  Pronto quando: o resultado é "Aprovado".  
  Comando: `carreira-verificar tutor_curriculos --entrada exemplos/f01/perfil_carreira.json --saida exemplos/f01/curriculo.json`  
  Responsável: David de Assis
- [x] **Criar uma conta num provedor de camada gratuita e gerar a chave (cada membro)**  
  Pronto quando: a chave está no .env de cada membro, e nunca no repositório.  
  Responsável: Gabriel
- [x] **Executar o módulo de exemplo do kit**  
  Pronto quando: exemplo-pitch executar gera a saída e exemplo-pitch servir abre a documentação em http://localhost:7777/docs.  
  Responsável: Thiago
- [x] **Criar o repositório privado no GitHub e dar acesso ao professor**  
  Pronto quando: o professor aparece como colaborador do repositório.  
  Responsável: Trindade
- [x] **Montar a estrutura do repositório a partir do módulo de exemplo**  
  Pronto quando: o repositório tem README.md, arquivo de dependências com o Agno fixado, .env.exemplo, .gitignore com .env e este CHECKLIST.md.  
  Responsável: David de Assis
- [x] **Fazer o agente principal responder**  
  Pronto quando: o agente entrevistador faz as primeiras perguntas do currículo.  
  Responsável: Gabriel

## Fase 2 — Contrato e apresentação parcial — apresentação parcial: 27/11/2026

- [x] **Implementar o núcleo mínimo do módulo**  
  Pronto quando: o tutor entrevista o formando e gera um Curriculo válido.  
  Responsável: Thiago
- [x] **Implementar as rotas do contrato**  
  Pronto quando: as rotas `POST /contrato/iniciar` e `GET /contrato/resultado/{id_sessao}`, além de `POST /contrato/executar` para importar um currículo antigo funcionam na documentação em /docs.  
  Responsável: Trindade
- [x] **Implementar a linha de comando**  
  Pronto quando: os comandos `executar`, `conversar` e `servir` funcionam.  
  Responsável: David de Assis
- [x] **Gerar as saídas do formando f01 e gravá-las em saidas/f01/**  
  Pronto quando: o verificador mostra "Aprovado" para os arquivos de saidas/f01/.  
  Comando: `carreira-verificar tutor_curriculos --entrada caminho/do/kit/exemplos/f01/perfil_carreira.json --saida saidas/f01/curriculo.json`  
  Responsável: Gabriel
- [x] **Preparar a demonstração parcial**  
  Pronto quando: o módulo roda do início ao fim na frente de outra pessoa, sem ajustes de última hora.  
  Responsável: Thiago
- [x] **Apresentar no dia 27/11 e anotar as sugestões do professor**  
  Pronto quando: as sugestões estão anotadas no fim deste checklist ou como issues no GitHub.  
  Responsável: Trindade

## Fase 3 — Funcionalidades e testes — meta sugerida: 04/12/2026

- [x] **F1. Entrevista guiada**  
  Pronto quando: funciona pela linha de comando e pela interface gráfica, e aparece na tabela de funcionalidades do relatório.  
  Responsável: David de Assis
- [x] **F2. Importação de currículo antigo**  
  Pronto quando: funciona pela linha de comando e pela interface gráfica, e aparece na tabela de funcionalidades do relatório.  
  Responsável: Gabriel
- [x] **F3. Uso do PerfilCarreira**  
  Pronto quando: funciona pela linha de comando e pela interface gráfica, e aparece na tabela de funcionalidades do relatório.  
  Responsável: Thiago
- [x] **F4. Agente revisor**  
  Pronto quando: funciona pela linha de comando e pela interface gráfica, e aparece na tabela de funcionalidades do relatório.  
  Responsável: Trindade
- [x] **F5. Perguntas de aprofundamento**  
  Pronto quando: funciona pela linha de comando e pela interface gráfica, e aparece na tabela de funcionalidades do relatório.  
  Responsável: David de Assis
- [x] **F6. Adaptação do currículo a uma vaga**  
  Pronto quando: funciona pela linha de comando e pela interface gráfica, e aparece na tabela de funcionalidades do relatório.  
  Responsável: Gabriel
- [x] **F7. Exportação em Markdown e Typst**  
  Pronto quando: funciona pela linha de comando e pela interface gráfica, e aparece na tabela de funcionalidades do relatório.  
  Responsável: Thiago
- [x] **F8. Memória e histórico de versões**  
  Pronto quando: funciona pela linha de comando e pela interface gráfica, e aparece na tabela de funcionalidades do relatório.  
  Responsável: Trindade
- [x] **Conectar a interface gráfica do AgentOS**  
  Pronto quando: o painel os.agno.com ou a Agent UI mostra o agente e as sessões.  
  Responsável: David de Assis
- [x] **Tratar o erro de limite de requisições (HTTP 429)**  
  Pronto quando: o módulo espera e tenta de novo, sem quebrar.  
  Responsável: Gabriel
- [x] **Escrever testes automatizados das partes feitas em código (cálculos, conversões, validações e rotas)**  
  Pronto quando: pytest passa, com testes que não dependem do modelo de linguagem.  
  Responsável: Thiago
- [x] **Gerar as saídas dos formandos f02 e f03 e gravá-las em saidas/f02/ e saidas/f03/**  
  Pronto quando: o verificador mostra "Aprovado" para os três formandos.  
  Responsável: Trindade

## Fase 4 — Avaliação, relatório e apresentação — entrega final: 11/12/2026

- [x] **Montar pelo menos 20 casos de teste com o resultado esperado de cada um**  
  Pronto quando: os casos e os resultados esperados estão no repositório, registrados antes da execução.  
  Responsável: David de Assis
- [x] **Executar os casos de teste e calcular as métricas do caderno**  
  Pronto quando: a tabela de resultados está preenchida no relatório.  
  Responsável: Gabriel
- [x] **Analisar as falhas encontradas**  
  Pronto quando: a seção de análise de falhas tem exemplos concretos.  
  Responsável: Thiago
- [x] **Opcional, com bônus: comparar dois modelos de linguagem nos mesmos casos**  
  Pronto quando: a comparação está no relatório.  
  Responsável: Trindade
- [x] **Escrever o relatório a partir do modelo do kit**  
  Pronto quando: todas as seções estão preenchidas e as caixas de orientação foram apagadas.  
  Responsável: David de Assis
- [x] **Escrever a seção sobre o uso de ferramentas de IA**  
  Pronto quando: a seção diz quais ferramentas foram usadas e como o resultado foi conferido.  
  Responsável: Gabriel
- [x] **Compilar o relatório e gravar relatorio/relatorio.pdf no repositório**  
  Pronto quando: o PDF tem até 12 páginas, sem contar capa, sumário e referências.  
  Responsável: Thiago
- [x] **Preparar a apresentação de 15 minutos com demonstração**  
  Pronto quando: o grupo ensaiou e coube em 15 minutos.  
  Responsável: Trindade
- [x] **Garantir que todos os membros sabem explicar o código**  
  Pronto quando: cada membro explicou para o grupo uma parte que não foi ele quem escreveu.  
  Responsável: David de Assis
- [x] **Rodar o conferidor de entrega**  
  Pronto quando: todos os itens aparecem com ✅.  
  Comando: `carreira-checar-entrega tutor_curriculos --kit caminho/do/kit`  
  Responsável: Gabriel
- [x] **Enviar o último commit para o GitHub até 11/12**  
  Pronto quando: o último commit aparece no GitHub com a data correta.  
  Responsável: Thiago

## Sugestões recebidas na apresentação parcial

- Manter fidelidade estrita às evidências nas habilidades.
- Garantir exportação para Typst compilável sem avisos.

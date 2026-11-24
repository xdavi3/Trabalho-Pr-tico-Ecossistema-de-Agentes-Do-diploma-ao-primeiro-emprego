# Modelo do relatório

| Arquivo | Conteúdo |
|---|---|
| `relatorio.typ` | O relatório a preencher. É o único arquivo `.typ` que vocês editam. |
| `referencias.bib` | As referências bibliográficas, em formato BibTeX. |
| `modelo_ifes.typ`, `ifes-horizontal-color.png` e `ifes-horizontal-white.png` | O visual do Ifes. Não alterem estes arquivos. |

## Como compilar

Usem o Typst de uma destas formas: no navegador, em typst.app, enviando todos os arquivos desta pasta para um projeto vazio; no VS Code, com a extensão Tinymist (comando "Typst Preview"); ou na linha de comando, com `typst watch relatorio.typ`, que gera `relatorio.pdf` e o atualiza a cada vez que o arquivo é salvo.

## Passo a passo

1. **Capa.** No início de `relatorio.typ`, preencham `title` com o número e o nome do módulo, `author` com os nomes curtos (usados no cabeçalho) e `cover-authors` com os nomes completos e as matrículas.
2. **Texto.** Escrevam cada seção seguindo as caixas e apaguem as caixas à medida que avançarem.
3. **Figuras.** Coloquem as imagens na pasta `figuras/` e troquem `#let figuras-prontas = false` por `true`; enquanto for `false`, cada figura aparece como um retângulo provisório.
4. **Tabelas.** Troquem cada `[...]` pelos valores do grupo e acrescentem as linhas necessárias.

## Citações

Para citar, escrevam `@` seguido da chave da obra: `@russell2022` ou `@agno`. A lista de referências, no padrão ABNT, é montada automaticamente apenas com as obras citadas. Para citar outra obra, acrescentem a entrada BibTeX dela em `referencias.bib`; toda referência precisa corresponder a uma obra real, que vocês consultaram.

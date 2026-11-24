// Visual institucional do Ifes para relatórios, reunido num único arquivo a partir do pacote ifes (licença no fim deste arquivo). Não altere este arquivo.

// ---- core/strings.typ
// Textos exibidos pelo pacote, por idioma. O idioma vem de `text.lang`, definido pelos layouts com o parâmetro `lang`; idiomas ausentes da tabela usam o inglês. Para acrescentar um idioma, adicione uma entrada com as mesmas chaves de "en".

/// Textos do pacote por idioma (`pt`, `en` e `es`). Cada idioma é um dicionário com as mesmas chaves; alguns valores são funções, como `copyright-course`, que recebe o título do livro. O idioma do documento é escolhido pelo parâmetro `lang` dos layouts; idiomas ausentes usam `en`. Textos isolados podem ser trocados pelo parâmetro `strings` dos layouts.
/// -> dictionary
#let translations = (
  pt: (
    contents: "Sumário",
    list-of-figures: "Lista de Figuras",
    list-of-tables: "Lista de Tabelas",
    chapter: "Capítulo",
    part: "Parte",
    appendices: "Apêndices",
    index: "Índice Remissivo",
    professor: "Professor(a)",
    points: "pts",
    algorithm: "Algoritmo",
    algorithm-function: "função",
    algorithm-procedure: "procedimento",
    algorithm-if: "se",
    algorithm-then: "então",
    algorithm-else: "senão",
    algorithm-else-if: "senão se",
    algorithm-while: "enquanto",
    algorithm-for: "para",
    algorithm-do: "faça",
    algorithm-repeat: "repita",
    algorithm-until: "até que",
    algorithm-end: "fim",
    algorithm-return: "retorne",
    algorithm-break: "interrompa",
    algorithm-terminate: "termine",
    info: "Informação",
    tip: "Dica",
    warning: "Atenção",
    danger: "Cuidado",
    note: "Nota",
    def: "Definição",
    example: "Exemplo",
    theorem: "Teorema",
    lemma: "Lema",
    definition: "Definição",
    corollary: "Corolário",
    proposition: "Proposição",
    axiom: "Axioma",
    claim: "Afirmação",
    notation: "Notação",
    exercise: "Exercício",
    solution: "Solução",
    problem: "Problema",
    vocabulary: "Vocabulário",
    proof: "Demonstração",
    published-by: "Publicado por",
    copyright-course: title => [Este material foi produzido para a disciplina #title. O uso deste arquivo é regido pelas normas internas da instituição. Salvo indicação em contrário, a reprodução é permitida para fins educacionais e não comerciais, desde que citada a fonte.],
    copyright-responsibility: "Os conceitos e opiniões expressos nesta obra são de exclusiva responsabilidade do autor.",
    edition: year => [Edição de #year],
    alt-ifes: "Logotipo do Instituto Federal do Espírito Santo",
    alt-decorative: "Imagem decorativa em tons de verde",
    alt-cover: "Padrão geométrico decorativo da capa",
    alt-placeholder: "Imagem de exemplo",
  ),
  en: (
    contents: "Contents",
    list-of-figures: "List of Figures",
    list-of-tables: "List of Tables",
    chapter: "Chapter",
    part: "Part",
    appendices: "Appendices",
    index: "Index",
    professor: "Instructor",
    points: "pts",
    algorithm: "Algorithm",
    algorithm-function: "function",
    algorithm-procedure: "procedure",
    algorithm-if: "if",
    algorithm-then: "then",
    algorithm-else: "else",
    algorithm-else-if: "else if",
    algorithm-while: "while",
    algorithm-for: "for",
    algorithm-do: "do",
    algorithm-repeat: "repeat",
    algorithm-until: "until",
    algorithm-end: "end",
    algorithm-return: "return",
    algorithm-break: "break",
    algorithm-terminate: "terminate",
    info: "Information",
    tip: "Tip",
    warning: "Warning",
    danger: "Caution",
    note: "Note",
    def: "Definition",
    example: "Example",
    theorem: "Theorem",
    lemma: "Lemma",
    definition: "Definition",
    corollary: "Corollary",
    proposition: "Proposition",
    axiom: "Axiom",
    claim: "Claim",
    notation: "Notation",
    exercise: "Exercise",
    solution: "Solution",
    problem: "Problem",
    vocabulary: "Vocabulary",
    proof: "Proof",
    published-by: "Published by",
    copyright-course: title => [This material was produced for the course #title. Its use is governed by the internal rules of the institution. Unless otherwise noted, reproduction is permitted for educational and non-commercial purposes, provided the source is cited.],
    copyright-responsibility: "The concepts and opinions expressed in this work are the sole responsibility of the author.",
    edition: year => [#year edition],
    alt-ifes: "Logo of the Federal Institute of Espírito Santo",
    alt-decorative: "Decorative image in shades of green",
    alt-cover: "Decorative geometric pattern of the cover",
    alt-placeholder: "Sample image",
  ),
  es: (
    contents: "Índice",
    list-of-figures: "Índice de Figuras",
    list-of-tables: "Índice de Tablas",
    chapter: "Capítulo",
    part: "Parte",
    appendices: "Apéndices",
    index: "Índice Alfabético",
    professor: "Profesor(a)",
    points: "ptos",
    algorithm: "Algoritmo",
    algorithm-function: "función",
    algorithm-procedure: "procedimiento",
    algorithm-if: "si",
    algorithm-then: "entonces",
    algorithm-else: "sino",
    algorithm-else-if: "sino si",
    algorithm-while: "mientras",
    algorithm-for: "para",
    algorithm-do: "hacer",
    algorithm-repeat: "repetir",
    algorithm-until: "hasta que",
    algorithm-end: "fin",
    algorithm-return: "devolver",
    algorithm-break: "interrumpir",
    algorithm-terminate: "terminar",
    info: "Información",
    tip: "Consejo",
    warning: "Atención",
    danger: "Cuidado",
    note: "Nota",
    def: "Definición",
    example: "Ejemplo",
    theorem: "Teorema",
    lemma: "Lema",
    definition: "Definición",
    corollary: "Corolario",
    proposition: "Proposición",
    axiom: "Axioma",
    claim: "Afirmación",
    notation: "Notación",
    exercise: "Ejercicio",
    solution: "Solución",
    problem: "Problema",
    vocabulary: "Vocabulario",
    proof: "Demostración",
    published-by: "Publicado por",
    copyright-course: title => [Este material fue producido para la asignatura #title. Su uso se rige por las normas internas de la institución. Salvo indicación en contrario, se permite la reproducción con fines educativos y no comerciales, siempre que se cite la fuente.],
    copyright-responsibility: "Los conceptos y opiniones expresados en esta obra son responsabilidad exclusiva del autor.",
    edition: year => [Edición de #year],
    alt-ifes: "Logotipo del Instituto Federal de Espírito Santo",
    alt-decorative: "Imagen decorativa en tonos de verde",
    alt-cover: "Patrón geométrico decorativo de la portada",
    alt-placeholder: "Imagen de ejemplo",
  ),
)

#let fallback-lang = "en"

// Substituições de textos definidas pelo parâmetro `strings` dos layouts, válidas para o documento inteiro.
#let string-overrides = state("ifes-string-overrides", (:))

// Valor do texto `key` no idioma vigente (`text.lang`), considerando as substituições do parâmetro `strings` do layout. Exige contexto.
#let string-at(key) = {
  let overrides = string-overrides.get()
  if key in overrides { return overrides.at(key) }
  let table = translations.at(text.lang, default: translations.at(fallback-lang))
  assert(key in table, message: "ifes: texto desconhecido \"" + key + "\"")
  table.at(key)
}

// Valida o parâmetro `strings` dos layouts: apenas chaves conhecidas.
#let check-overrides(strings) = {
  assert(type(strings) == dictionary, message: "ifes: `strings` deve ser um dicionário, ex.: (professor: \"Orientador(a)\")")
  for key in strings.keys() {
    assert(key in translations.at(fallback-lang), message: "ifes: texto desconhecido \"" + key + "\" em `strings`. Chaves válidas: " + translations.at(fallback-lang).keys().join(", "))
  }
  strings
}

// ---- core/colors.typ
// Cores institucionais: paletas nomeadas e derivação de todos os tons a partir de uma única cor primária.

/// Paletas nomeadas disponíveis para o parâmetro `color` dos layouts.
/// -> dictionary
#let palettes = (
  "ifes-green": rgb("#006b52"),
  "dark-green": rgb("#0f5c4d"),
  "emerald": rgb("#1a6e54"),
  "sapphire-blue": rgb("#1e5a96"),
  "navy-blue": rgb("#0d3b66"),
  "cherry-red": rgb("#8b3a3a"),
  "wine": rgb("#6b2c2c"),
)

/// Nome da paleta usada quando nenhuma cor é informada.
/// -> str
#let default-color = "ifes-green"

/// Converte o nome de uma paleta, uma cor ou uma paleta completa (dicionário com os tons de @@palette()) em um valor `color`, com erro descritivo para nomes desconhecidos; da paleta completa, devolve `primary`.
/// -> color
#let resolve-color(
  /// Nome de uma paleta de @@palettes, uma cor qualquer, ex.: `rgb("#123456")`, ou uma paleta completa.
  /// -> str | color | dictionary
  value,
) = {
  if type(value) == color { return value }
  if type(value) == dictionary { return value.primary }
  assert(type(value) == str, message: "ifes: `color` deve ser uma cor ou o nome de uma paleta, recebido " + repr(value))
  assert(value in palettes, message: "ifes: paleta desconhecida \"" + value + "\". Opções: " + palettes.keys().join(", "))
  palettes.at(value)
}

/// Chaves de uma paleta completa.
#let _palette-keys = ("primary", "secondary", "dark", "link", "muted", "line", "tint", "code-number", "zebra", "table-odd", "table-even")

/// Todos os tons usados pelos layouts e componentes, derivados da cor primária. As chaves são `primary`, `secondary`, `dark`, `link`, `muted`, `line`, `tint`, `code-number`, `zebra`, `table-odd` e `table-even`. Um dicionário com essas chaves (a paleta completa de um projeto que define os tons por conta própria) é devolvido como está, sem derivação.
///
/// ```example
/// #let p = palette("sapphire-blue")
/// #box(fill: p.tint, stroke: p.line, inset: 6pt, text(fill: p.primary)[Texto])
/// ```
/// -> dictionary
#let palette(
  /// Nome de uma paleta de @@palettes, uma cor qualquer ou uma paleta completa.
  /// -> str | color | dictionary
  color,
) = {
  if type(color) == dictionary {
    let faltam = _palette-keys.filter(k => k not in color)
    assert(faltam.len() == 0, message: "ifes: paleta completa sem as chaves " + faltam.join(", "))
    return color
  }
  let p = resolve-color(color)
  (
    primary: p,
    secondary: p.darken(10%),
    dark: p.darken(60%),
    link: p.darken(25%),
    muted: p.desaturate(60%).darken(20%),
    line: p.lighten(60%),
    tint: p.lighten(92%),
    code-number: p.lighten(40%),
    zebra: p.lighten(96%),
    table-odd: p.lighten(88%),
    table-even: p.lighten(94%),
  )
}

/// Cor primária do documento atual. Os layouts a definem no início do corpo; os componentes a leem em contexto.
/// -> state
#let current-color = state("ifes-primary-color", resolve-color(default-color))

/// Executa `fn` com a paleta do documento atual, para construir elementos próprios que acompanhem a cor do layout.
///
/// ```example
/// #with-palette(p => text(fill: p.primary)[Na cor do documento])
/// ```
/// -> content
#let with-palette(
  /// Função que recebe a paleta retornada por @@palette() e retorna conteúdo.
  /// -> function
  fn,
) = context fn(palette(current-color.get()))

// ---- core/utils.typ
// Utilitários internos: conversão de conteúdo em texto, truncamento, ordenação alfabética, rótulos de página, normalização de margens e recuo de parágrafo.

// Converte conteúdo em string percorrendo a árvore; elementos sem texto (espaços, quebras, equações) viram " ".
#let plain-text(it) = {
  if it == none { return "" }
  if type(it) == str { return it }
  if type(it) != content { return str(it) }
  if it.has("text") { return plain-text(it.text) }
  if it.has("children") { return it.children.map(plain-text).sum(default: "") }
  if it.has("body") { return plain-text(it.body) }
  if it.has("child") { return plain-text(it.child) }
  if it.func() == smartquote { return if it.double { "\"" } else { "'" } }
  " "
}

// Trunca por grafemas (seguro para acentos), acrescentando "…" quando necessário.
#let truncate(it, n) = {
  let s = plain-text(it).trim()
  let graphemes = s.clusters()
  if graphemes.len() <= n { s } else { graphemes.slice(0, n).join().trim() + "…" }
}

// Normaliza autor(es) para lista de strings: aceita string, conteúdo ou array deles.
#let author-list(author) = {
  let items = if type(author) == array { author } else { (author,) }
  items.filter(a => a != none).map(plain-text)
}

#let _accents = (
  "á": "a", "à": "a", "â": "a", "ã": "a", "ä": "a", "é": "e", "è": "e", "ê": "e", "ë": "e", "í": "i", "ì": "i", "î": "i", "ï": "i",
  "ó": "o", "ò": "o", "ô": "o", "õ": "o", "ö": "o", "ú": "u", "ù": "u", "û": "u", "ü": "u", "ç": "c", "ñ": "n",
)

// Chave de ordenação sem acentos e sem distinção de maiúsculas, para ordem alfabética em línguas latinas.
#let sort-key(s) = lower(s).clusters().map(g => _accents.at(g, default: g)).join()

// Rótulo da página em `loc` conforme a numeração de página vigente ali (ex.: "iii" ou "12").
#let page-label(loc) = {
  let pattern = loc.page-numbering()
  if pattern == none { str(counter(page).at(loc).first()) } else { numbering(pattern, ..counter(page).at(loc)) }
}

// Normaliza margens (comprimento ou dicionário com as chaves de `page.margin`) em (top, bottom, left, right, mirrored) absolutos; `mirrored` indica margens `inside`/`outside`, que se espelham nas páginas pares.
#let resolve-margin(margin) = {
  let valid = ("top", "bottom", "left", "right", "inside", "outside", "x", "y", "rest")
  if type(margin) == length { return (top: margin, bottom: margin, left: margin, right: margin, mirrored: false) }
  assert(type(margin) == dictionary, message: "ifes: `margin` deve ser um comprimento ou um dicionário, ex.: (x: 3cm, top: 3cm, bottom: 2.5cm)")
  for (key, value) in margin {
    assert(key in valid, message: "ifes: chave de margem desconhecida \"" + key + "\". Opções: " + valid.join(", "))
    assert(type(value) == length, message: "ifes: a margem \"" + key + "\" deve ser um comprimento absoluto, ex.: 2cm")
  }
  let mirrored = "inside" in margin or "outside" in margin
  assert(not (mirrored and ("left" in margin or "right" in margin)), message: "ifes: `margin` não pode combinar left/right com inside/outside")
  let rest = margin.at("rest", default: 2.5cm)
  let x = margin.at("x", default: rest)
  let y = margin.at("y", default: rest)
  (
    top: margin.at("top", default: y),
    bottom: margin.at("bottom", default: y),
    left: margin.at(if mirrored { "inside" } else { "left" }, default: x),
    right: margin.at(if mirrored { "outside" } else { "right" }, default: x),
    mirrored: mirrored,
  )
}

// Margens esquerda e direita efetivas na página física `page-number`; margens espelhadas trocam de lado nas páginas pares.
#let side-margins(m, page-number) = if m.mirrored and calc.even(page-number) { (left: m.right, right: m.left) } else { (left: m.left, right: m.right) }

// Parágrafos: `false` sem recuo (espaço entre parágrafos), `true` com recuo de 1em (estilo do orange-book) ou um comprimento de recuo.
#let paragraph-indent(value) = {
  assert(type(value) in (bool, length), message: "ifes: `first-line-indent` deve ser true, false ou um comprimento, ex.: 1.5em")
  if value == true { 1em } else if value == false { 0em } else { value }
}

// Pontuação da bibliografia: o estilo ABNT (e outros CSL) acrescenta um ponto depois de um título que já termina em interrogação ou exclamação, como em "Quem sobreviverá?."; esta regra tira esse ponto, inclusive quando o título está em negrito ou itálico (livros), caso em que o ponto é um texto separado do título e é reconhecido por um marcador invisível (U+200B) posto logo depois dele.
#let bibliography-punctuation(it) = {
  let marca(s) = if s.body.has("text") and (s.body.text.ends-with("?") or s.body.text.ends-with("!")) { s; "\u{200B}" } else { s }
  show regex("[?!]\."): m => m.text.first()
  show strong: marca
  show emph: marca
  show regex("\u{200B}\."): ""
  it
}

// ---- core/identity.typ
// Dados institucionais e acesso aos logotipos e imagens distribuídos com o pacote.


/// Dados da instituição usados na afiliação padrão da capa e no texto de copyright do livro. Chaves: `name`, `acronym`, `campus`, `department` e `website`.
/// -> dictionary
#let institution = (
  name: "Instituto Federal do Espírito Santo",
  acronym: "IFES",
  campus: "",
  department: "",
  website: "https://www.ifes.edu.br",
)

/// Afiliação padrão exibida na capa dos documentos.
/// -> str
#let default-affiliation = if institution.campus == "" { institution.acronym } else { institution.acronym + " — " + institution.campus }

#let _logos = (
  "ifes-horizontal-color", "ifes-horizontal-white", "ifes-horizontal-grayscale", "ifes-horizontal-black",
  "ifes-vertical-color", "ifes-vertical-white", "ifes-vertical-grayscale", "ifes-vertical-black",
)

#let _images = (
  "cover-background": (file: "cover-background.png", alt: "alt-cover"),
  "chapter-1": (file: "chapter-1.jpg", alt: "alt-decorative"),
  "chapter-2": (file: "chapter-2.jpg", alt: "alt-decorative"),
  "chapter-3": (file: "chapter-3.jpg", alt: "alt-decorative"),
  "placeholder": (file: "placeholder.jpg", alt: "alt-placeholder"),
)

/// Logotipo distribuído com o pacote, com texto alternativo padrão no idioma do documento (exigido por PDF/UA). Nomes disponíveis: `ifes-{horizontal,vertical}-{color,white,grayscale,black}`.
///
/// ```example
/// #logo("ifes-horizontal-color", width: 4cm)
/// ```
/// -> content
#let logo(
  /// Nome do logotipo.
  /// -> str
  name,
  /// Texto alternativo; `auto` usa a descrição da instituição no idioma do documento, `none` omite.
  /// -> auto | none | str
  alt: auto,
  /// Argumentos repassados a `image`, ex.: `width: 5cm`.
  /// -> arguments
  ..args,
) = {
  assert(name in _logos, message: "ifes: logo desconhecido \"" + name + "\". Opções: " + _logos.join(", "))
  context image(name + ".png", alt: if alt == auto { string-at("alt-" + name.split("-").first()) } else { alt }, ..args)
}

/// Imagem distribuída com o pacote, com texto alternativo padrão no idioma do documento. Nomes disponíveis: `cover-background`, `chapter-1`, `chapter-2`, `chapter-3` e `placeholder`.
/// -> content
#let package-image(
  /// Nome da imagem.
  /// -> str
  name,
  /// Texto alternativo; `auto` usa a descrição da imagem no idioma do documento, `none` omite.
  /// -> auto | none | str
  alt: auto,
  /// Argumentos repassados a `image`, ex.: `width: 50%`.
  /// -> arguments
  ..args,
) = {
  assert(name in _images, message: "ifes: imagem desconhecida \"" + name + "\". Opções: " + _images.keys().join(", "))
  let entry = _images.at(name)
  context image("../assets/images/" + entry.file, alt: if alt == auto { string-at(entry.alt) } else { alt }, ..args)
}

// ---- core/code.typ
// Blocos de código nativos: moldura na cor do documento, numeração de linhas, zebra, rótulo da linguagem, intervalos, saltos e destaques. Os números de linha são marcados como artefatos do PDF, fora do texto lido por leitores de tela.

// Nome exibido para cada linguagem; linguagens ausentes mostram a própria etiqueta do bloco (ex.: ```xyz).
#let _language-names = (
  bash: "Bash", c: "C", cpp: "C++", cs: "C#", csharp: "C#", css: "CSS", go: "Go", html: "HTML", java: "Java", js: "JavaScript", javascript: "JavaScript", json: "JSON", julia: "Julia", kotlin: "Kotlin", latex: "LaTeX", tex: "LaTeX", lua: "Lua", markdown: "Markdown", md: "Markdown", matlab: "MATLAB", php: "PHP", py: "Python", python: "Python", r: "R", ruby: "Ruby", rust: "Rust", rs: "Rust", scala: "Scala", sh: "Shell", sql: "SQL", swift: "Swift", toml: "TOML", ts: "TypeScript", typescript: "TypeScript", typ: "Typst", typc: "Typst", typst: "Typst", xml: "XML", yaml: "YAML", yml: "YAML",
)

// Ativação global dos blocos estilizados e opções do bloco corrente (definidas por `code-block`).
#let _enabled = state("ifes-code-enabled", true)
#let _local = state("ifes-code-local", none)

#let _defaults(decorations) = (numbers: decorations, first-number: 1, lines: none, skips: (), highlight: (), label: if decorations { auto } else { none }, zebra: decorations)

// Linhas visíveis com o número exibido, aplicando intervalo, deslocamento e saltos; cada salto vira uma linha "⋮".
#let _rows(lines, opts) = {
  let kept = if opts.lines == none { lines } else { lines.filter(l => l.number >= opts.lines.at(0) and l.number <= opts.lines.at(1)) }
  let rows = ()
  let shift = opts.first-number - 1
  for l in kept {
    for s in opts.skips.filter(s => s.at(0) == l.number) {
      rows.push((skip: true, number: none, body: none, original: none))
      shift += s.at(1)
    }
    rows.push((skip: false, number: l.number + shift, body: l.body, original: l.number))
  }
  rows
}

#let _code-block(it, p, opts) = {
  let rows = _rows(it.lines, opts)
  let strut = sym.zws
  let label = if opts.label == auto { if it.lang != none { _language-names.at(lower(it.lang), default: it.lang) } } else { opts.label }
  let badge = if label != none { box(fill: p.tint, inset: (x: 0.4em, y: 0.2em), radius: 3pt, stroke: 0.4pt + p.line, text(size: 7pt, fill: p.code-number, label)) }
  // A primeira linha reserva à direita o espaço do rótulo, para que o código não fique por baixo dele.
  let reserve = if badge != none { measure(badge).width + 0.8em } else { 0pt }
  let fill-of(i, row) = if row.original != none and row.original in opts.highlight { p.primary.lighten(75%) } else if opts.zebra and calc.even(i) { p.zebra } else { none }
  let cells = rows.enumerate().map(((i, row)) => {
    let fill = fill-of(i, row)
    let body = if row.skip { text(fill: p.code-number, sym.dots.v) } else [#row.body#strut]
    // O rótulo fica dentro da primeira célula de código, para aparecer no primeiro trecho do bloco quando ele quebra entre páginas e acima do fundo da linha.
    if i == 0 and badge != none { body = [#body#place(top + right, dx: reserve + 0.2em, dy: -0.1em, pdf.artifact(badge))] }
    let code = grid.cell(fill: fill, inset: (left: 0.6em, right: 0.6em + if i == 0 { reserve } else { 0pt }, y: 0.22em), body)
    if not opts.numbers { return (code,) }
    let number = if row.skip { [] } else { pdf.artifact(text(size: 8pt, fill: p.code-number, str(row.number))) }
    (grid.cell(fill: fill, inset: (left: 0.6em, right: 0.3em, y: 0.22em), align: right + horizon, number), code)
  }).flatten()
  block(width: 100%, breakable: true, fill: p.tint, stroke: 0.5pt + p.line, radius: 5pt, clip: true, inset: (y: 0.3em), {
    set align(left)
    grid(columns: if opts.numbers { (auto, 1fr) } else { (1fr,) }, ..cells)
  })
}

// Regra `show` aplicada pelos layouts: `show: code-style.with(palette(...))`. Com `decorations: false`, os blocos ficam sem numeração de linhas, zebra e rótulo da linguagem, mantendo a moldura.
#let code-style(p, decorations: true, body) = {
  show raw.where(block: true): set text(size: 9pt)
  show raw.where(block: true): it => context {
    if not _enabled.get() { return it }
    let local = _local.get()
    _code-block(it, p, _defaults(decorations) + if local == none { (:) } else { local })
  }
  show raw.where(block: false): box.with(fill: p.tint, inset: (x: 3pt), outset: (y: 3pt), radius: 2pt)
  body
}

/// Opções para os blocos de código em `body`: numeração, intervalo de linhas, saltos, destaques e rótulo. Parâmetros omitidos mantêm o padrão do layout (definido por `code-decorations`).
///
/// ````example
/// #code-block(first-number: 10, highlight: (2,), label: "Python 3")[
///   ```python
///   x = 1
///   y = x + 1
///   ```
/// ]
/// ````
/// -> content
#let code-block(
  /// Numera as linhas.
  /// -> auto | bool
  numbers: auto,
  /// Número exibido na primeira linha.
  /// -> int
  first-number: 1,
  /// Intervalo de linhas exibidas, `(início, fim)` pela numeração original do bloco; `none` exibe todas.
  /// -> none | array
  lines: none,
  /// Saltos: pares `(linha, quantidade)` que inserem "⋮" antes da linha e avançam a numeração em `quantidade`, ex.: `((4, 20),)`.
  /// -> array
  skips: (),
  /// Linhas destacadas, pela numeração original do bloco, ex.: `(2, 5)`.
  /// -> array
  highlight: (),
  /// Rótulo no canto superior direito: `auto` usa o nome da linguagem, `none` omite.
  /// -> auto | none | str | content
  label: auto,
  /// Faixas alternadas nas linhas.
  /// -> auto | bool
  zebra: auto,
  /// Blocos de código aos quais as opções se aplicam.
  /// -> content
  body,
) = {
  assert(type(first-number) == int, message: "ifes: `first-number` deve ser um inteiro")
  assert(lines == none or (type(lines) == array and lines.len() == 2 and lines.all(n => type(n) == int)), message: "ifes: `lines` deve ser none ou (início, fim)")
  assert(type(skips) == array and skips.all(s => type(s) == array and s.len() == 2 and s.all(n => type(n) == int)), message: "ifes: `skips` deve ser um array de pares (linha, quantidade), ex.: ((4, 20),)")
  assert(type(highlight) == array and highlight.all(n => type(n) == int), message: "ifes: `highlight` deve ser um array de números de linha")
  let opts = (first-number: first-number, lines: lines, skips: skips, highlight: highlight)
  if numbers != auto { opts.insert("numbers", numbers) }
  if zebra != auto { opts.insert("zebra", zebra) }
  if label != auto { opts.insert("label", label) }
  _local.update(opts)
  body
  _local.update(none)
}

/// Desativa o estilo dos blocos de código seguintes, que passam a usar a aparência padrão do Typst, até @@code-enable().
/// -> content
#let code-disable() = _enabled.update(false)

/// Reativa o estilo dos blocos de código depois de @@code-disable().
/// -> content
#let code-enable() = _enabled.update(true)

// ---- core/algorithm.typ
// Pseudocódigo nativo: construtores que produzem linhas com recuo, a tabela numerada `algorithm` e a figura `algorithm-figure`. As palavras-chave seguem o idioma do documento (chaves "algorithm-*" de strings.typ). A interface é compatível com a do pacote algorithmic 1.0.


// Linha de pseudocódigo: conteúdo e nível de recuo relativo ao bloco que a contém.
#let _line(body, indent: 0) = (ifes-algorithm-line: true, indent: indent, body: body)

#let _is-line(item) = type(item) == dictionary and item.at("ifes-algorithm-line", default: false)

// Achata os itens de um corpo (linhas, arrays de linhas, conteúdo ou texto) em linhas, somando `extra` ao recuo.
#let _lines(items, extra: 0) = {
  let out = ()
  for item in items {
    if item == none { continue }
    if _is-line(item) {
      out.push((..item, indent: item.indent + extra))
    } else if type(item) == array {
      out += _lines(item, extra: extra)
    } else {
      out.push(_line([#item], indent: extra))
    }
  }
  out
}

#let _kw(key) = strong(context string-at("algorithm-" + key))

#let _args(args) = if type(args) == array { args.map(a => [#a]).join(", ") } else { args }

#let _call(name, args, style: smallcaps) = [#style(name)\(#_args(args)\)]

// Bloco com cabeçalho, corpo recuado e, opcionalmente, a linha "fim".
#let _block(header, body, end: true) = (_line(header),) + _lines(body, extra: 1) + if end { (_line(_kw("end")),) } else { () }

// Construtores de blocos. `end: false` omite a linha "fim" (usado por `IfElseChain`).
#let Function(name, args, ..body) = _block([#_kw("function") #_call(name, args)], body.pos())
#let Procedure(name, args, ..body) = _block([#_kw("procedure") #_call(name, args)], body.pos())
#let If(cond, end: true, ..body) = _block([#_kw("if") #cond #_kw("then")], body.pos(), end: end)
#let ElseIf(cond, end: true, ..body) = _block([#_kw("else-if") #cond #_kw("then")], body.pos(), end: end)
#let Else(end: true, ..body) = _block(_kw("else"), body.pos(), end: end)
#let While(cond, ..body) = _block([#_kw("while") #cond #_kw("do")], body.pos())
#let For(cond, ..body) = _block([#_kw("for") #cond #_kw("do")], body.pos())
#let Repeat(..body, until) = (_line(_kw("repeat")),) + _lines(body.pos(), extra: 1) + (_line([#_kw("until") #until]),)

/// Cadeia se / senão se / senão, sem linhas "fim" intermediárias: `IfElseChain(cond1, corpo1, cond2, corpo2, ..., corpo-senão)`. Cada corpo é uma instrução ou um array de instruções; o último corpo, sem condição, é o "senão" (opcional).
/// -> array
#let IfElseChain(
  /// Condições e corpos alternados, com um corpo final opcional para o "senão".
  /// -> any
  ..conditions-and-bodies,
) = {
  let items = conditions-and-bodies.pos()
  let has-else = calc.odd(items.len())
  let pairs = calc.quo(items.len(), 2)
  let arrayify(v) = if type(v) == array { v } else { (v,) }
  let result = ()
  for k in range(pairs) {
    let last = k == pairs - 1 and not has-else
    let block = if k == 0 { If } else { ElseIf }
    result += block(items.at(2 * k), end: last, ..arrayify(items.at(2 * k + 1)))
  }
  if has-else { result += Else(..arrayify(items.last())) }
  result
}

// Instruções de uma linha.
#let State(body) = (_line(body),)
#let LineBreak = State([])
#let Assign(var, val) = (_line([#var #sym.arrow.l #val]),)
#let Return(..arg) = (_line([#_kw("return")#if arg.pos().len() > 0 [ #arg.pos().first()]]),)
#let Break = (_line(smallcaps(context string-at("algorithm-break"))),)
#let Terminate = (_line(smallcaps(context string-at("algorithm-terminate"))),)
#let CallInline(name, args) = _call(name, args)
#let FnInline(f, args) = _call(f, args, style: strong)
#let CommentInline(c) = [#sym.triangle.stroked.r #c]
#let Call(..args) = (_line(CallInline(..args)),)
#let Fn(..args) = (_line(FnInline(..args)),)
#let Comment(c) = (_line(CommentInline(c)),)

/// Instrução com comentário alinhado à direita, ex.: `LineComment(Assign("i", "0"), "início")`.
/// -> array
#let LineComment(instruction, c) = {
  let lines = _lines((instruction,))
  let first = lines.first()
  ((..first, body: [#first.body#h(1fr)#CommentInline(c)]),) + lines.slice(1)
}

/// Pseudocódigo em tabela, com linhas numeradas e recuo por nível de bloco. Os passos são escritos com os construtores `Function`, `Procedure`, `If`, `ElseIf`, `Else`, `IfElseChain`, `While`, `For`, `Repeat`, `Assign`, `Return`, `Break`, `Terminate`, `State`, `LineBreak` (linha vazia), `Call`, `Fn`, `Comment` e `LineComment`, e com as versões em linha `CallInline`, `FnInline` e `CommentInline`. As palavras-chave (se, enquanto, retorne…) seguem o idioma do documento. Normalmente usado dentro de @@algorithm-figure().
/// -> content
#let algorithm(
  /// Espaçamento interno das células (altura das linhas).
  /// -> length | dictionary
  inset: 0.2em,
  /// Idioma das palavras-chave; `auto` usa o do documento, ex.: `lang: "en"` para palavras-chave em inglês num texto em português.
  /// -> auto | str
  lang: auto,
  /// Numera as linhas.
  /// -> bool
  line-numbers: true,
  /// Recuo por nível de bloco.
  /// -> length
  indent: 1em,
  /// Passos do algoritmo.
  /// -> any
  ..steps,
) = {
  let lines = _lines(steps.pos())
  let cells = lines.enumerate().map(((i, l)) => {
    let body = pad(left: l.indent * indent, l.body)
    if line-numbers { ([#(i + 1):], body) } else { (body,) }
  }).flatten()
  set text(lang: lang) if lang != auto
  show table.cell: set text(weight: "regular")
  table(columns: if line-numbers { (auto, 1fr) } else { (1fr,) }, align: if line-numbers { (right, left) } else { left }, inset: inset, stroke: none, ..cells)
}

/// Pseudocódigo como figura numerada "Algoritmo N" (rótulo e palavras-chave no idioma do documento). Como as demais figuras, não quebra entre páginas; para algoritmos longos, use `#show figure.where(kind: "algorithm"): set block(breakable: true)`, e o título se repetirá na continuação. Aceita os parâmetros de @@algorithm().
///
/// ```example
/// #algorithm-figure(
///   "Máximo",
///   Function("Max", ("a", "b"),
///     IfElseChain([$a > b$], Return[$a$], Return[$b$]),
///   ),
/// )
/// ```
/// -> content
#let algorithm-figure(
  /// Título exibido na legenda.
  /// -> str | content
  title,
  /// Rótulo da figura; `auto` usa "Algoritmo" no idioma do documento.
  /// -> auto | str | content
  supplement: auto,
  /// Passos e parâmetros de @@algorithm() (`inset`, `lang`, `line-numbers`, `indent`).
  /// -> any
  ..args,
) = figure(
  kind: "algorithm",
  supplement: if supplement == auto { context string-at("algorithm") } else { supplement },
  caption: title,
  placement: none,
  algorithm(..args),
)

// Regra `show` aplicada pelos layouts: figura de algoritmo com fios acima e abaixo e o título como cabeçalho da tabela, repetido se a figura quebrar entre páginas.
#let algorithm-style(body) = {
  show figure.where(kind: "algorithm"): it => {
    set align(left)
    table(
      columns: 1,
      stroke: none,
      table.header(table.hline(), strong(it.caption), table.hline()),
      it.body,
      table.hline(),
    )
  }
  body
}

// ---- core/environments.typ
// Ambientes numerados (teorema, lema, definição, exercício etc.) implementados como figuras, o que os torna referenciáveis com rótulos e compatíveis com PDF/UA. A aparência de cada ambiente viaja no próprio `kind` da figura ("ifes-env:" seguido da especificação), de modo que ambientes criados com `new-environment` usam a mesma regra de exibição. A numeração é "capítulo.n", reiniciada a cada título de nível 1 pelos layouts (ver `reset-environments`).


#let _prefix = "ifes-env:"
#let _frames = ("box", "bar", "plain")

// Estilo de numeração do capítulo corrente: "1" no corpo do documento, "A" nos apêndices do livro.
#let chapter-style = state("ifes-chapter-style", "1")

// Rótulo do capítulo em `loc` (ex.: "2" ou "B"), ou `none` antes do primeiro título numerado.
#let chapter-label-at(loc) = {
  let n = counter(heading).at(loc).first()
  if n == 0 { none } else { numbering(chapter-style.at(loc), n) }
}

// Número "capítulo.n" de um elemento em `loc`, ex.: "2.3" ou "A.1"; apenas "n" antes do primeiro capítulo.
#let chapter-numbering-at(loc, n) = {
  let chapter = chapter-label-at(loc)
  if chapter == none { str(n) } else { chapter + "." + str(n) }
}

// Numeração "capítulo.n" avaliada no contexto do elemento numerado (figuras, equações e ambientes).
#let chapter-numbering(..nums) = chapter-numbering-at(here(), nums.pos().last())

// Reinicia a numeração de todos os ambientes presentes no documento, inclusive os criados com `new-environment`; os layouts chamam esta função a cada título de nível 1.
#let reset-environments() = context {
  for kind in query(figure).map(f => f.kind).filter(k => type(k) == str and k.starts-with(_prefix)).dedup() {
    counter(figure.where(kind: kind)).update(0)
  }
}

#let _resolve(value, c) = {
  if value == auto { c } else if value == "tint" { c.lighten(90%) } else if value == "soft" { c.lighten(95%) } else { value }
}

// Regra `show` aplicada pelos layouts: desenha cada ambiente conforme a especificação contida no `kind`.
#let environment-style(body) = {
  show figure: it => {
    if type(it.kind) != str or not it.kind.starts-with(_prefix) { return it }
    let spec = eval(it.kind.slice(_prefix.len()))
    let c = current-color.get()
    let label = if spec.key != none { string-at(spec.key) } else { spec.supplement }
    let number = if it.numbering != none { " " + it.counter.display(it.numbering) }
    let title-fill = if spec.title-color == none { black } else { _resolve(spec.title-color, c) }
    let title = strong(text(fill: title-fill, [#spec.marker#label#number]))
    let name = if it.caption != none [ *--- #it.caption.body.*]
    let stroke = _resolve(spec.stroke, c)
    let (inset, frame-stroke) = if spec.frame == "box" {
      (0.65em, 0.5pt + stroke)
    } else if spec.frame == "bar" {
      ((x: 0.65em, y: if spec.fill == none { 0.1em } else { 0.65em }), (left: 4pt + stroke))
    } else {
      (0em, none)
    }
    set align(left)
    set par(first-line-indent: 0em)
    block(width: 100%, breakable: spec.breakable, fill: _resolve(spec.fill, c), stroke: frame-stroke, inset: inset, above: 1.2em, below: 1.2em)[#title#name#h(0.2em)#it.body]
  }
  body
}

// Especificação completa de um ambiente; `key` aponta para o rótulo traduzido em strings.typ, `supplement` é o rótulo fixo dos ambientes do usuário.
#let _spec(key: none, supplement: none, frame: "plain", title-color: none, fill: none, stroke: none, breakable: false, marker: "", numbered: true) = {
  assert(frame in _frames, message: "ifes: `frame` deve ser um de: " + _frames.join(", "))
  for (field, value) in (title-color: title-color, fill: fill, stroke: stroke) {
    assert(value == none or value == auto or type(value) == color or value in ("tint", "soft"), message: "ifes: `" + field + "` deve ser none, auto, uma cor, \"tint\" ou \"soft\"")
  }
  assert(type(breakable) == bool and type(numbered) == bool, message: "ifes: `breakable` e `numbered` devem ser booleanos")
  (key: key, supplement: supplement, frame: frame, title-color: title-color, fill: fill, stroke: stroke, breakable: breakable, marker: marker, numbered: numbered)
}

#let _make(spec) = (body, name: none) => figure(
  kind: _prefix + repr(spec),
  supplement: if spec.key != none { context string-at(spec.key) } else { spec.supplement },
  numbering: if spec.numbered { chapter-numbering } else { none },
  caption: name,
  outlined: false,
  body,
)

/// Cria um novo ambiente, com os mesmos recursos dos ambientes do pacote: numeração por capítulo, referências com rótulos e acompanhamento da cor do documento. Retorna uma função com a assinatura `(body, name: none)`.
///
/// ```example
/// #let hypothesis = new-environment("Hipótese", frame: "bar", fill: "tint")
/// #hypothesis(name: "H1")[O modelo generaliza para dados não vistos.]
/// ```
/// -> function
#let new-environment(
  /// Rótulo exibido antes do número, ex.: "Hipótese". Ambientes com a mesma especificação compartilham a numeração.
  /// -> str
  supplement,
  /// Moldura: `"box"` (contorno), `"bar"` (faixa lateral) ou `"plain"` (sem moldura).
  /// -> str
  frame: "plain",
  /// Cor do título: `none` (preto), `auto` (cor do documento) ou uma cor.
  /// -> none | auto | color
  title-color: none,
  /// Fundo: `none`, `auto` (cor do documento), `"tint"` e `"soft"` (tons claros da cor do documento) ou uma cor.
  /// -> none | auto | str | color
  fill: none,
  /// Cor da moldura: `none`, `auto` (cor do documento) ou uma cor.
  /// -> none | auto | color
  stroke: auto,
  /// Permite quebrar o ambiente entre páginas.
  /// -> bool
  breakable: false,
  /// Texto antes do rótulo, ex.: `"■ "`.
  /// -> str
  marker: "",
  /// Numera o ambiente ("capítulo.n"); sem número, o ambiente não pode ser referenciado.
  /// -> bool
  numbered: true,
) = {
  assert(type(supplement) == str and supplement != "", message: "ifes: `new-environment` exige um rótulo (string) não vazio")
  _make(_spec(supplement: supplement, frame: frame, title-color: title-color, fill: fill, stroke: stroke, breakable: breakable, marker: marker, numbered: numbered))
}

/// Teorema numerado por capítulo, isto é, por título de nível 1 (ex.: "Teorema 2.1"; antes do primeiro título, só o número), referenciável com um rótulo: `#theorem[...] <thm-x>` e depois `@thm-x`. Os ambientes `lemma`, `definition`, `corollary`, `proposition`, `axiom`, `claim`, `notation`, `exercise`, `solution`, `example`, `problem` e `vocabulary` têm os mesmos parâmetros e diferem apenas no estilo. O rótulo segue o idioma do documento.
///
/// ```example
/// #theorem(name: "Pitágoras")[Em todo triângulo retângulo, $a^2 = b^2 + c^2$.]
/// ```
/// -> content
#let theorem(
  /// Conteúdo do ambiente.
  /// -> content
  body,
  /// Nome exibido após o número, ex.: "Pitágoras"; `none` omite.
  /// -> none | str | content
  name: none,
) = _make(_spec(key: "theorem", frame: "box", title-color: auto, fill: luma(95%), stroke: auto))(body, name: name)

// Demais ambientes do pacote, com os mesmos parâmetros de `theorem`.
#let lemma = _make(_spec(key: "lemma", frame: "box", title-color: auto, fill: luma(95%), stroke: auto))
#let definition = _make(_spec(key: "definition", frame: "bar", stroke: auto))
#let corollary = _make(_spec(key: "corollary", frame: "bar", fill: luma(95%), stroke: gray))
#let proposition = _make(_spec(key: "proposition", title-color: auto))
#let axiom = _make(_spec(key: "axiom", frame: "bar", title-color: auto, stroke: auto))
#let claim = _make(_spec(key: "claim"))
#let notation = _make(_spec(key: "notation"))
#let exercise = _make(_spec(key: "exercise", frame: "bar", title-color: auto, fill: "tint", stroke: auto))
#let solution = _make(_spec(key: "solution", frame: "bar", title-color: auto, fill: "soft", stroke: auto, breakable: true))
#let example = _make(_spec(key: "example", breakable: true))
#let problem = _make(_spec(key: "problem", title-color: auto))
#let vocabulary = _make(_spec(key: "vocabulary", marker: "■ "))

/// Demonstração não numerada: título em itálico, corpo e o símbolo ∎ alinhado à direita no fim. O título segue o idioma do documento.
///
/// ```example
/// #proof(name: "do Teorema 2.1")[Segue diretamente da definição.]
/// ```
/// -> content
#let proof(
  /// Conteúdo da demonstração.
  /// -> content
  body,
  /// Complemento do título, ex.: "do Teorema 2.1"; `none` omite.
  /// -> none | str | content
  name: none,
) = block(width: 100%, above: 1.2em, below: 1.2em, breakable: true)[#emph[#context string-at("proof")#if name != none [ #name].] #body#h(1fr)#sym.qed]

/// Observação não numerada, com um marcador circular "R" na cor do documento.
///
/// ```example
/// #remark[Esquemas de resfriamento geométricos são o padrão na prática.]
/// ```
/// -> content
#let remark(
  /// Conteúdo da observação.
  /// -> content
  body,
) = context {
  let c = current-color.get()
  block(above: 1.2em, below: 1.2em, grid(
    columns: (1.2cm, 1fr),
    align: (center + horizon, left),
    circle(radius: 0.3cm, fill: c.lighten(70%), stroke: c.lighten(30%), align(center + horizon, text(fill: c, weight: "bold")[R])),
    body,
  ))
}

// ---- core/components.typ
// Componentes visuais independentes de layout: caixas de destaque, fórmulas, tabelas, divisórias e questões. A cor primária vem do estado `current-color`, definido pelo layout em uso.


// Cor `auto` significa "usar a cor primária do documento".
#let _callout-styles = (
  info: rgb("#2980b9"),
  tip: rgb("#27ae60"),
  warning: rgb("#d68910"),
  danger: rgb("#c0392b"),
  note: rgb("#8e44ad"),
  def: rgb("#534ab7"),
  example: auto,
)

/// Caixa de destaque com faixa lateral colorida e título. Normalmente usada pelos atalhos `box-info` (azul), `box-tip` (verde), `box-warning` (laranja), `box-danger` (vermelha), `box-note` (roxa), `box-def` (índigo) e `box-example` (cor do documento), que aceitam os mesmos argumentos, exceto `kind`.
///
/// ```example
/// #callout("tip", title: "Dica de ouro")[Compile com frequência.]
/// ```
/// -> content
#let callout(
  /// Tipo da caixa: `"info"`, `"tip"`, `"warning"`, `"danger"`, `"note"`, `"def"` ou `"example"`. O tipo `"example"` usa a cor do documento.
  /// -> str
  kind,
  /// Conteúdo da caixa.
  /// -> content
  body,
  /// Título exibido em negrito; `none` usa o rótulo padrão do tipo no idioma do documento (ex.: "Dica").
  /// -> none | str | content
  title: none,
) = {
  assert(kind in _callout-styles, message: "ifes: tipo de caixa desconhecido \"" + kind + "\". Opções: " + _callout-styles.keys().join(", "))
  context {
    let heading-text = if title in (none, "", []) { string-at(kind) } else { title }
    let c = if _callout-styles.at(kind) == auto { current-color.get() } else { _callout-styles.at(kind) }
    block(
      width: 100%,
      breakable: true,
      fill: c.lighten(88%),
      stroke: (left: 4pt + c),
      radius: (right: 5pt),
      inset: (left: 12pt, right: 10pt, y: 8pt),
    )[
      #text(weight: "bold", fill: c.darken(20%), heading-text) \
      #body
    ]
  }
}

// Atalhos de `callout`, documentados na descrição de `callout`.
#let box-info = callout.with("info")
#let box-tip = callout.with("tip")
#let box-warning = callout.with("warning")
#let box-danger = callout.with("danger")
#let box-note = callout.with("note")
#let box-def = callout.with("def")
#let box-example = callout.with("example")

/// Equação em destaque dentro de um bloco com fundo na cor do documento. A numeração e os rótulos da equação são preservados.
///
/// ```example
/// #formula[$ f(n) = O(n log n) $]
/// ```
/// -> content
#let formula(
  /// Equação (ou qualquer conteúdo) a destacar.
  /// -> content
  body,
  /// Texto alternativo da equação, exigido por PDF/UA; `none` omite.
  /// -> none | str
  alt: none,
) = with-palette(p => block(
  width: 100%,
  fill: p.tint,
  stroke: 0.4pt + p.line,
  radius: 5pt,
  inset: (x: 16pt, y: 10pt),
)[
  #set text(fill: p.primary.darken(20%))
  #set math.equation(alt: alt) if alt != none
  #align(center, body)
])

/// Equação de bloco sem numeração, mesmo quando o documento numera equações. Como não tem número, não pode ser referenciada.
///
/// ```example
/// #unnumbered($ a^2 + b^2 = c^2 $)
/// ```
/// -> content
#let unnumbered(
  /// Equação.
  /// -> content
  body,
  /// Texto alternativo da equação, exigido por PDF/UA; `none` omite.
  /// -> none | str
  alt: none,
) = {
  set math.equation(numbering: none)
  set math.equation(alt: alt) if alt != none
  body
}

/// Tabela com cabeçalho na cor do documento e linhas zebradas. O cabeçalho se repete quando a tabela quebra entre páginas. Para legendar e numerar como tabela, envolva-a em `figure(kind: table, ...)`.
///
/// ```example
/// #styled-table(
///   headers: ("Algoritmo", "Custo"),
///   rows: (([Busca linear], $O(n)$), ([Busca binária], $O(log n)$)),
///   align: (left, center),
/// )
/// ```
/// -> content
#let styled-table(
  /// Títulos das colunas; definem o número de colunas.
  /// -> array
  headers: (),
  /// Linhas da tabela, cada uma um array com uma célula por coluna.
  /// -> array
  rows: (),
  /// Larguras das colunas; `auto` divide a largura igualmente.
  /// -> auto | array
  col-widths: auto,
  /// Alinhamento das células do corpo: um valor para todas ou um array com um valor por coluna; o cabeçalho é sempre centralizado.
  /// -> alignment | array
  align: left,
  /// Tamanho da fonte do cabeçalho.
  /// -> length
  header-size: 10pt,
  /// Tamanho da fonte das células.
  /// -> length
  cell-size: 9.5pt,
  /// Espaçamento interno das células; aumente `y` para linhas mais altas (ex.: para preenchimento manual).
  /// -> length | dictionary
  row-inset: (x: 8pt, y: 7pt),
) = {
  let n = headers.len()
  assert(n > 0, message: "ifes: styled-table exige ao menos um cabeçalho")
  let cells = rows.flatten()
  assert(calc.rem(cells.len(), n) == 0, message: "ifes: styled-table: o número total de células (" + str(cells.len()) + ") não é múltiplo do número de colunas (" + str(n) + ")")
  let widths = if col-widths == auto { (1fr,) * n } else { col-widths }
  let alignments = if type(align) == array { align } else { (align,) * n }
  set par(justify: false, first-line-indent: 0em)
  with-palette(p => table(
    columns: widths,
    stroke: 0.5pt + p.line,
    inset: row-inset,
    fill: (_, y) => if y == 0 { p.primary } else if calc.odd(y) { p.table-odd } else { p.table-even },
    table.header(..headers.map(h => table.cell(align: center, text(weight: "bold", fill: white, size: header-size, h)))),
    ..cells.enumerate().map(((i, cell)) => table.cell(align: alignments.at(calc.rem(i, n)), text(size: cell-size, cell))),
  ))
}

/// Faixa com a aparência de um título de nível 1, fora do sumário e da numeração de títulos. Útil para agrupar módulos ou blocos de questões.
///
/// ```example
/// #section[Módulo 1 — Fundamentos]
/// ```
/// -> content
#let section(
  /// Texto da faixa.
  /// -> content
  body,
) = with-palette(p => block(
  width: 100%,
  above: 1.4em,
  below: 1.1em,
  fill: p.primary,
  radius: 6pt,
  inset: (x: 14pt, y: 10pt),
  text(fill: white, size: 15pt, weight: "bold", body),
))

/// Rótulo leve para subagrupar conteúdo dentro de uma @@section(), fora do sumário.
///
/// ```example
/// #topic[Perceptron e MLP]
/// ```
/// -> content
#let topic(
  /// Texto do rótulo.
  /// -> content
  body,
) = with-palette(p => block(
  above: 1em,
  below: 0.6em,
  text(weight: "bold", size: 11pt, fill: p.secondary, body),
))

/// Contador das questões criadas por @@question(); numeração contínua no documento inteiro. Use `question-counter.update(0)` para reiniciar.
/// -> counter
#let question-counter = counter("ifes-question")

/// Questão numerada automaticamente, com tipo e pontuação opcionais.
///
/// ```example
/// #question("Cálculo", points: "2,0")[Quanto vale $2 + 2$?]
/// ```
/// -> content
#let question(
  /// Tipo da questão, exibido em itálico entre parênteses (ex.: "Dissertativa").
  /// -> str | content
  kind,
  /// Enunciado.
  /// -> content
  body,
  /// Pontuação exibida após o tipo; `none` omite.
  /// -> none | str | content
  points: none,
) = {
  question-counter.step()
  block(above: 1.1em, below: 1.1em, width: 100%, context {
    strong(question-counter.display() + ".")
    [ ]
    text(style: "italic", weight: "bold")[(#kind)]
    if points != none {
      [ ]
      text(fill: current-color.get().darken(15%), weight: "bold")[[#points #string-at("points")]]
    }
    h(0.35em)
    body
  })
}

// ---- core/document.typ
// Layout-base de documentos (notas de aula, apostilas e relatórios), em A4 por padrão: capa, sumário, cabeçalho, rodapé e tipografia. Os layouts públicos `notes` e `report` são especializações deste, com padrões próprios.


#let _logo-variants = ("color", "white")

// Logotipo da capa: `auto` usa o logo IFES na variante escolhida, `none` omite, conteúdo é usado como está e um array de conteúdos é exibido lado a lado.
#let _cover-logo(value, variant, p) = {
  if type(value) == array { return grid(columns: value.len(), column-gutter: 1.5cm, align: horizon, ..value) }
  if value != auto { return value }
  assert(variant in _logo-variants, message: "ifes: `logo-variant` deve ser \"color\" ou \"white\"")
  if variant == "color" {
    logo("ifes-horizontal-color", width: 5cm)
  } else {
    block(fill: p.primary, radius: 6pt, inset: (x: 12pt, y: 10pt), logo("ifes-horizontal-white", width: 5cm))
  }
}

#let _cover(p, title, subtitle, authors, cover-authors, professor, course, affiliation, date, logo) = page(header: none, footer: none, {
  set align(center)
  logo
  v(1fr)
  if course != none {
    text(size: 14pt, weight: "semibold", fill: p.secondary, upper(course))
    v(1cm)
  }
  block(width: 90%, fill: p.primary, radius: 8pt, inset: (x: 20pt, y: 15pt), {
    set par(justify: false)
    text(size: 20pt, weight: "bold", fill: white, hyphenate: false, title)
  })
  if subtitle != none {
    v(1cm)
    text(size: 18pt, weight: "bold", fill: p.primary, subtitle)
  }
  v(1cm)
  line(length: 60%, stroke: 1.5pt + p.primary)
  v(1fr)
  {
    set text(size: if cover-authors == none { 16pt } else { 14pt }, weight: "bold", fill: p.secondary)
    if cover-authors != none { cover-authors } else { authors.join(linebreak()) }
  }
  if professor != none {
    v(1cm)
    text(size: 14pt, fill: p.secondary)[#context string-at("professor"): #professor]
  }
  v(1fr)
  text(size: 13pt, fill: p.secondary)[#affiliation | #date]
})

#let _footer(p, pattern) = context align(center, text(size: 9pt, fill: p.muted, counter(page).display(pattern, both: pattern.contains("/"))))

#let _header(p, title, course, authors, max-length) = {
  set text(size: 8pt, fill: p.muted)
  let left-text = if course != none { plain-text(course) + " | " + plain-text(title) } else { plain-text(title) }
  grid(
    columns: (2fr, 1fr),
    column-gutter: 1em,
    align: (left, right),
    truncate(left-text, max-length),
    authors.join(", "),
  )
  v(-0.5em)
  line(length: 100%, stroke: 0.4pt + p.line)
}

/// Layout-base de @@notes() e @@report(): página (A4 por padrão) com capa, sumário, cabeçalho com curso, título e autores, e rodapé "página / total". Capa e sumário não entram na numeração do corpo; o sumário usa algarismos romanos. Todos os parâmetros abaixo valem para `notes` e `report`.
/// -> content
#let base-document(
  /// Título do documento (capa, cabeçalho e metadados do PDF).
  /// -> str | content
  title: "Título do Documento",
  /// Subtítulo exibido na capa; `none` omite.
  /// -> none | str | content
  subtitle: none,
  /// Autor ou lista de autores (nomes curtos), usados no cabeçalho e nos metadados do PDF.
  /// -> str | array
  author: "Autor",
  /// Conteúdo que substitui a lista de autores na capa, ex.: nomes completos e matrículas.
  /// -> none | content
  cover-authors: none,
  /// Professor(a) responsável, exibido na capa como "Professor(a): ..." (rótulo no idioma do documento, alterável com `strings`); `none` omite.
  /// -> none | str | content
  professor: none,
  /// Nome do curso ou disciplina, exibido na capa (em maiúsculas) e no cabeçalho.
  /// -> none | str | content
  course: none,
  /// Data exibida na capa.
  /// -> str | content
  date: datetime.today().display("[day]/[month]/[year]"),
  /// Afiliação exibida na capa.
  /// -> str | content
  affiliation: default-affiliation,
  /// Nome de uma paleta ou uma cor; todos os tons do documento derivam dela.
  /// -> str | color
  color: default-color,
  /// Logotipo da capa: `auto` usa o logo IFES, `none` omite, conteúdo é usado como está; um array de conteúdos é exibido lado a lado, ex.: `(logo("ifes-horizontal-color", width: 5cm), image("outro-logo.png", width: 4cm))`.
  /// -> auto | none | content | array
  logo: auto,
  /// Variante do logo IFES quando `logo` é `auto`: `"color"` ou `"white"` (sobre tarja na cor do documento).
  /// -> str
  logo-variant: "color",
  /// Exibe a capa.
  /// -> bool
  show-cover: true,
  /// Exibe o sumário.
  /// -> bool
  show-outline: true,
  /// Profundidade de títulos no sumário.
  /// -> int
  outline-depth: 2,
  /// Numeração de linhas, zebra e rótulo da linguagem nos blocos de código.
  /// -> bool
  code-decorations: true,
  /// Tamanho da fonte do texto.
  /// -> length
  font-size: 12pt,
  /// Tamanho dos títulos de nível 1; cada nível abaixo é 5% menor.
  /// -> length
  size-h1: 15pt,
  /// Máximo de caracteres do texto à esquerda do cabeçalho (curso e título), com reticências quando excedido.
  /// -> int
  header-max-length: 70,
  /// Idioma do documento (código ISO 639-1): define os textos do pacote (ver `translations`), a hifenização e os textos do próprio Typst. Idiomas sem tradução no pacote usam os textos em inglês.
  /// -> str
  lang: "pt",
  /// Região do idioma, ex.: `"BR"` ou `"PT"`; `auto` usa `"BR"` para português e nenhuma para os demais idiomas.
  /// -> auto | none | str
  region: auto,
  /// Substituições pontuais dos textos do pacote, ex.: `(professor: "Orientador(a)")`. As chaves válidas são as de `translations.en`.
  /// -> dictionary
  strings: (:),
  /// Tamanho do papel, com os nomes aceitos por `page`, ex.: `"a4"`, `"a5"`, `"us-letter"`.
  /// -> str
  paper: "a4",
  /// Margens da página: um comprimento ou um dicionário com as chaves de `page.margin` (ex.: `(x: 2cm, y: 2.5cm)` ou `(inside: 3cm, outside: 2cm, y: 2.5cm)`).
  /// -> length | dictionary
  margin: 2.5cm,
  /// Recuo da primeira linha dos parágrafos: `false` (parágrafos separados por espaço), `true` (recuo de 1em com parágrafos juntos) ou um comprimento.
  /// -> bool | length
  first-line-indent: false,
  /// Referências em minúsculas (ex.: "figura 2" em vez de "Figura 2").
  /// -> bool
  lowercase-references: false,
  /// Conteúdo do documento.
  /// -> content
  body,
) = {
  let overrides = check-overrides(strings)
  let indent = paragraph-indent(first-line-indent)
  let p = palette(color)
  let authors = author-list(author)

  set document(title: plain-text(title), author: authors)
  set page(
    paper: paper,
    margin: margin,
    header: _header(p, title, course, authors, header-max-length),
    footer: _footer(p, "1 / 1"),
  )
  set text(font: "Libertinus Serif", size: font-size, lang: lang, region: if region == auto { if lang == "pt" { "BR" } else { none } } else { region })
  set par(justify: true, leading: 0.85em, spacing: if indent == 0em { 1em } else { 0.85em }, first-line-indent: indent)
  set ref(supplement: it => { let sup = it.at("supplement", default: none); if sup == none { none } else { lower(sup) } }) if lowercase-references
  set math.equation(numbering: "(1)")
  set enum(indent: 2em, body-indent: 0.8em, spacing: 0.9em)
  set list(indent: 2em, body-indent: 0.8em, spacing: 0.9em)

  set heading(numbering: "1.1.1.")
  show heading: set block(above: 1.4em, below: 0.8em, sticky: true)
  show heading: it => {
    let size = size-h1 * calc.pow(0.95, it.level - 1)
    if it.level == 1 {
      reset-environments()
      block(width: 100%, above: 1.6em, below: 1.2em, sticky: true, fill: p.primary, radius: 6pt, inset: (x: 14pt, y: 10pt), text(size: size, weight: "bold", fill: white, it))
    } else {
      set text(size: size, weight: "semibold", fill: p.primary)
      it
    }
  }

  show link: set text(fill: p.link)
  show cite: set text(fill: p.link)
  show bibliography: bibliography-punctuation
  show table: set text(size: 11pt)
  show table.cell.where(y: 0): set text(weight: "bold")
  show: code-style.with(p, decorations: code-decorations)
  show: environment-style
  show: algorithm-style

  current-color.update(p.primary)
  string-overrides.update(overrides)

  if show-cover {
    _cover(p, title, subtitle, authors, cover-authors, professor, course, affiliation, date, _cover-logo(logo, logo-variant, p))
  }

  if show-outline {
    set page(footer: _footer(p, "i"))
    counter(page).update(1)
    show outline.entry.where(level: 1): set text(weight: "bold")
    context outline(title: block(width: 100%, align(center, string-at("contents"))), indent: 1.5em, depth: outline-depth)
    pagebreak(weak: true)
  }

  counter(page).update(1)
  body
}

// ---- layouts/report.typ
// Layout de relatórios técnicos e institucionais.


/// Relatórios técnicos, de projeto ou de atividades: capa, sumário e data completa. Aceita todos os parâmetros de @@base-document(); `cover-authors` e `professor` permitem também relatórios de alunos.
///
/// ```typ
/// #show: report.with(title: "Relatório Técnico", author: ("Prof. A", "Prof. B"))
/// ```
/// -> content
#let report = base-document.with(date: datetime.today().display("[day]/[month]/[year]"))

/*
MIT License

Copyright (c) 2026 Sérgio Nery Simões

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

The files under assets/logos are not covered by this license; see assets/NOTICE.

*/

#import "../../lib.typ": syntree
#set document(date: none)
#set page(width: auto, height: auto, margin: 0.5cm, fill: white)

#syntree(
  nonterminal: (style: "italic"),
  terminal: (fill: blue),
  child-spacing: 3em, // default: 1em
  layer-spacing: 2em, // default: 2.3em
)[
  [S [NP This] [VP [V is] [^NP a wug]]]
]

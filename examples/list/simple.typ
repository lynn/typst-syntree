#import "../../lib.typ": listtree
#set document(date: none)
#set page(width: auto, height: auto, margin: 0.5cm, fill: white)

#listtree(
  nonterminal: (style: "italic"),
  terminal: (fill: blue),
  child-spacing: 3em, // default: 1em
  layer-spacing: 2em, // default: 2.3em
)[
  - S
    - NP
      - This
    - VP
      - V
        - is
      - ^NP
        - a wug
]

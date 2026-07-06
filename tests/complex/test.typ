#import "../../lib.typ": syntree
#set document(date: none)
#set page(width: auto, height: auto, margin: 0.5cm, fill: white)

#figure(caption: "Example of a syntax tree.", gap: 2em)[
  #syntree(terminal: (fill: blue), nonterminal: (style: "italic"))[
    [S
      [NP
        [Det the]
        [Nom
          [Adj little]
          [N bear]
        ]
      ]
      [VP
        [VP
          [V saw]
          [NP
            [Det the]
            [Nom
              [Adj fine]
              [Adj fat]
              [N trout]
            ]
          ]
        ]
        [PP
          [P in]
          [^NP the brook]
        ]
      ]
    ]
  ]
]

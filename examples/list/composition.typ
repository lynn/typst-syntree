#import "../../lib.typ": listtree, syntree, tree
#set document(date: none)
#set page(width: auto, height: auto, margin: 0.5cm, fill: white)

#figure(caption: "Example of a syntax tree.", gap: 2em)[
  #listtree(nonterminal: (style: "italic"), terminal: (fill: blue))[
    - S
      - #syntree[
          [NP
            [Det the]
            [Nom
              [Adj little]
              [N bear]
            ]
          ]
        ]
      - VP
        - VP
          - V
            - saw
          - NP
            - Det
              - the
            #tree("Nom",
              tree("Adj", "fine"),
              tree("Adj", "fat"),
              tree("N", "trout"))
        - PP
          - P
            - in
          - ^NP
            - the brook
  ]
]

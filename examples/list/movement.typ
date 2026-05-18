#import "../../lib.typ": listtree
#set document(date: none)
#set page(width: 250pt, height: 260pt, margin: 0.5cm, fill: white)
#import "@preview/larrow:1.1.0": label-arrow

#listtree[
  - TP
    - ^NP
      - les feuilles
    - T'
      - T
        - tombaient <t-end>
      - VP#sub[main]
        - V'
          - ^AdvP
            - toujours
          - V'
            - #strike[V]
              - #strike[tombaient] <t-start>
]
#label-arrow(<t-start>, <t-end>, bend: -100,
  from-offset: (-5pt, -5pt), to-offset: (20pt, -15pt))

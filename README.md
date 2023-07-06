# typst-syntree

**syntree** is a typst package for rendering syntax trees -- the kind linguists use.

The name and syntax are inspired by Miles Shang's [syntree](https://github.com/mshang/syntree).

Here's an example to get started:

```typ
#import "@preview/syntree:0.0.1": syntree

#syntree(
  nonterminal: (fill: blue),
  terminal: (style: "italic"),
  "[S [NP This] [VP [V is] [^NP a wug]]]"
)
```

There's limited support for formulas inside nodes; try `#syntree("[DP$zws_i$ this]")` or `#syntree("[C $diameter$]")`.

For more flexible tree-drawing:

```typ
#import "@preview/syntree:0.0.1": tree

#tree("S", tree("NP")[$sqrt(pi)$], tree("VP", tree("V")[is], tree("Adj")[irrational]))
```

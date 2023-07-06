#let tree(tag, ..children, child-spacing: 1em, layer-spacing: 2.3em, roof: false, stroke: 0.75pt) = {
  let tag_text = text(tag)
  style(sty => {
    let child_widths = children.pos().map(c => measure(c, sty).width)
    let child_xs = ()
    let acc = 0pt
    for width in child_widths {
      child_xs.push(acc)
      acc += width + child-spacing
    }

    let children_width = acc - child-spacing

    let child_nodes = children.pos().enumerate().map(t => {
      let (i, child) = t
      let child_width = measure(child, sty).width
      let x0 = child_xs.at(i) + child_width / 2
      let hi = -layer-spacing + 0.3em
      let lo = -0.3em
      if roof {
        place(polygon(stroke: stroke, (0pt, hi), (children_width - x0, lo), (-x0, lo)))
      } else {
        place(line(stroke: stroke, start: (0pt, lo), end: (children_width / 2 - x0, hi)))
      }
      child
    })

    let child_stack = stack(dir: ltr, spacing: child-spacing, ..child_nodes)
    let layer_stack = stack(dir: ttb, spacing: layer-spacing, tag_text, child_stack)
    block(align(center, layer_stack))
  })
}

#let syntree(code, terminal: (:), nonterminal: (:), child-spacing: 1em, layer-spacing: 2.3em) = {
  let ct(x) = {
    while x.has("child") { x = x.child }
    x.text
  }

  let stack = ((),)
  for token in code.matches(regex("\\[|\\]|[^\\[\\]\\s]+")) {
    if token.text == "[" {
      stack.push(())
    } else if token.text == "]" {
      let (tag, ..children) = stack.pop()
      let roof = false
      if ct(tag).starts-with("^") {
        tag = text(..nonterminal, ct(tag).slice(1))
        children = (text(..terminal, children.map(ct).join(" ")),)
        roof = true
      }
      stack.last().push(tree(tag, ..children, child-spacing: child-spacing, layer-spacing: layer-spacing, roof: roof))
    } else {
      let sty = if stack.last().len() == 0 { nonterminal } else { terminal }
      stack.last().push(text(..sty, token.text))
    }
  }
  stack.last().last()
}

// #tree("S", tree("NP")[$sqrt(pi)$], tree("VP", tree("V")[is], tree("A")[irrational]))
//
// #figure(
//   caption: "Example of a syntaax tree.",
//   gap: 2em,
//   syntree(
//     nonterminal: (fill: blue),
//     terminal: (style: "italic"),
//     "[S [NP [Det the] [Nom [Adj little] [N bear]]] [VP [VP [V saw] [NP [Det the] [Nom [Adj fine] [Adj fat] [N trout]]]] [PP [P in] [^NP the brook]]]]"
//   )
// )

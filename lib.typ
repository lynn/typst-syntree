#let tree(tag, ..children, child-spacing: 1em, layer-spacing: 2.3em, roof: false, stroke: 0.75pt) = {
  let tag-text = text(tag)
  context {
    let child-widths = children.pos().map(c => measure(c).width)
    let child-xs = ()
    let acc = 0pt
    for width in child-widths {
      child-xs.push(acc)
      acc += width + child-spacing
    }

    let children-width = acc - child-spacing

    let child-nodes = children.pos().enumerate().map(t => {
      let (i, child) = t
      let child-width = measure(child).width
      let x0 = child-xs.at(i) + child-width / 2
      let hi = -layer-spacing + 0.3em
      let lo = -0.3em
      if roof {
        place(polygon(stroke: stroke, (0pt + child-width/2, hi), (children-width - x0 + child-width/2, lo), (-x0+ child-width/2, lo)))
      } else {
        place(line(stroke: stroke, start: (0pt+ child-width/2, lo), end: (children-width / 2 - x0+ child-width/2, hi)))
      }
      child
    })

    let child-stack = stack(dir: ltr, spacing: child-spacing, ..child-nodes)
    let layer-stack = stack(dir: ttb, spacing: layer-spacing, tag-text, child-stack)
    block(align(center, layer-stack))
  }
}

#let syntree(code, terminal: (:), nonterminal: (:), child-spacing: 1em, layer-spacing: 2.3em) = {
  let stack = ((),)
  let roof-stack = (false,)
  for token in code.matches(regex(`(\\\[|\\\]|[^\[\]\s])+|\[|\]`.text)) {
    if token.text == "[" {
      stack.push(())
      roof-stack.push(false)
    } else if token.text == "]" {
      let (tag, ..children) = stack.pop()
      let roof = roof-stack.pop()
      if roof {
        children = (text(..terminal, children.join([ ])),)
      }
      stack.last().push(tree(tag, ..children, child-spacing: child-spacing, layer-spacing: layer-spacing, roof: roof))
    } else {
      let sty = if stack.last().len() == 0 { nonterminal } else { terminal }
      let t = token.text
      if t.starts-with("^") {
        t = t.slice(1)
        roof-stack.last() = true
      }
      stack.last().push(text(..sty, eval("[" + t + "]")))
    }
  }
  stack.last().last()
}

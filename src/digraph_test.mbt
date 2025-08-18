///|
enum Expr {
  Add(Expr, Expr)
  Lit(Int)
}

///|
fn eval_path(self : Expr) -> Digraph {
  let edges = []
  let nodes = []
  let mut cnt = 0
  fn dfs(self : Expr) -> (Int, Int) {
    cnt += 1
    match self {
      Add(l, r) => {
        let from = cnt
        let (vl, il) = dfs(l)
        let (vr, ir) = dfs(r)
        let v = vl + vr
        edges.push(Edge::new(from~, to=il))
        edges.push(Edge::new(from~, to=ir))
        nodes.push(Node::new(id=from, label=v.to_string()))
        (v, from)
      }
      Lit(v) => {
        let id = cnt
        nodes.push(Node::new(id=cnt, label=v.to_string()))
        (v, cnt)
      }
    }
  }

  dfs(self) |> ignore
  { edges, nodes }
}

///|
fn dump_ast(self : Expr) -> Digraph {
  fn dfs(self : Expr) -> Tree {
    match self {
      Add(l, r) => {
        let tl = dfs(l)
        let tr = dfs(r)
        Tree::{ label: "+", children: [dfs(l), dfs(r)] }
      }
      Lit(x) => Tree::{ label: x.to_string(), children: [] }
    }
  }

  dfs(self).to_digraph()
}

///|
test (t : @test.T) {
  let expr = Add(Add(Lit(3), Lit(5)), Add(Lit(7), Lit(8)))
  t.writeln(expr.eval_path())
  t.snapshot(filename="expr.dot")
}

///|
test (t : @test.T) {
  let expr = Add(Add(Lit(3), Lit(5)), Add(Lit(7), Lit(8)))
  t.writeln(expr.dump_ast())
  t.snapshot(filename="ast.dot")
}

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
test (t : @test.T) {
  let expr = Add(Add(Lit(3), Lit(5)), Add(Lit(7), Lit(8)))
  t.buffer.write_object(expr.eval_path())
  t.snapshot!(filename="expr.dot")
}

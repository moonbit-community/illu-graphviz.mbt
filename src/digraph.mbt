///|
pub struct Edge {
  from : Int
  to : Int
  label : String
}

///|
pub struct Node {
  id : Int
  label : String
}

///|
pub fn Edge::new(from~ : Int, to~ : Int, label~ : String = "") -> Edge {
  { from, to, label }
}

///|
pub fn Node::new(id~ : Int, label~ : String) -> Node {
  { id, label }
}

///|
pub(all) struct Digraph {
  edges : Array[Edge]
  nodes : Array[Node]
}

///|
pub impl Show for Digraph with output(self, logger) {
  logger.write_string("\ndigraph {\n")
  logger.write_string("node [shape = box; style = filled;];\n")
  for edge in self.edges {
    logger.write_object(edge.from)
    logger.write_string("->")
    logger.write_object(edge.to)
    if not(edge.label.is_blank()) {
      logger.write_string("[label=\{edge.label.escape()};]")
    }
    logger.write_string(";\n")
  }
  for node in self.nodes {
    logger.write_string("\{node.id}[label=\{node.label.escape()};]")
  }
  logger.write_string("}\n")
}

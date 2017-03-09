# Network graph written in elm

![Travis.ci](https://travis-ci.org/iosphere/elm-network-graph.svg?branch=master)

A network graph consists of a list of nodes connected by edges.

## Types

### Graph

```elm
type alias Graph node =
    { edges : List Edge
    , nodes : List node
    }
```

A network graph consists of a list of nodes connected by edges.

The node type of the Graph is abstract to allow you to use records extending the
type Node. Most functions provided by this work with Graph Node.

## Output options

Two outputs are supported JSON or GraphViz:

```graphviz
digraph G { rankdir=TB
    "a" [shape=box style="bold, filled" fillColor="#ddd" label="a"];
    "b" [shape=box style="bold, filled" fillColor="#ddd" label="b"];
    "c" [shape=box style="bold, filled" fillColor="#ddd" label="c"];
    "a" -> "b";
    "b" -> "c";
    "c" -> "a";
}
```

![Screenshot of a GraphViz export as SVG](https://github.com/iosphere/elm-network-graph/raw/1.0.0/graphviz.png)


## Development

To install all tools and run `elm-make`: `make build`

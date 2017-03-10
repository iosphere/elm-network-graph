module Graph.GraphVizTests exposing (all)

import Expect
import Graph as Graph exposing (Graph)
import Graph.Edge exposing (Edge)
import Graph.Node as Node exposing (Node)
import Graph.GraphViz as GraphViz
import Test exposing (..)


all : Test
all =
    describe "Graph.GraphViz.Tests"
        [ testString ]


testString : Test
testString =
    test "Graph.GraphViz.string" <|
        \() ->
            GraphViz.string dummyGraph
                |> Expect.equal expected


expected : String
expected =
    """digraph G { rankdir=TB
"a" [shape=box style="bold, filled" fillColor="#ddd" label="a"];
"b" [shape=box style="bold, filled" fillColor="#ddd" label="b"];
"c" [shape=box style="bold, filled" fillColor="#ddd" label="c"];"a" -> "b";
"b" -> "c";
"c" -> "a";}"""


dummyNodes : List Node
dummyNodes =
    [ Node "a" [ "a" ], Node "b" [ "b" ], Node "c" [ "c" ] ]


dummyEdges : List Edge
dummyEdges =
    [ Edge "a" "b", Edge "b" "c", Edge "c" "a" ]


dummyGraph : Graph Node
dummyGraph =
    Graph dummyEdges dummyNodes

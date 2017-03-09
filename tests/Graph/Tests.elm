module Graph.Tests exposing (..)

import Expect
import Graph as Graph exposing (Graph)
import Graph.Edge exposing (Edge)
import Graph.Node as Node exposing (Node)
import Test exposing (..)


all : Test
all =
    describe "Graph.Tests"
        [ testFilter ]


testFilter : Test
testFilter =
    test "Graph.Tests.filter" <|
        \() ->
            filterGraph
                |> Expect.equal (Graph.filter filterFunc dummyGraph)


filterFunc : Node -> Bool
filterFunc node =
    (List.head node.name) == Just "b"


dummyNodes : List Node
dummyNodes =
    [ Node "a" [ "a" ] ] ++ filteredNodes


filteredNodes : List Node
filteredNodes =
    [ Node "b" [ "b" ], Node "b-1" [ "b", "1" ] ]


dummyEdges : List Edge
dummyEdges =
    [ Edge "a" "b" ] ++ filteredEdges


filteredEdges : List Edge
filteredEdges =
    [ Edge "b" "b-1" ]


dummyGraph : Graph Node
dummyGraph =
    Graph dummyEdges dummyNodes


filterGraph : Graph Node
filterGraph =
    Graph filteredEdges filteredNodes

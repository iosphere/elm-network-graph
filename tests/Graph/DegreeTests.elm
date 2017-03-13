module Graph.DegreeTests exposing (all)

import Dict
import Expect
import Graph as Graph exposing (Graph)
import Graph.Degree as Degree exposing (Degree)
import Graph.Edge exposing (Edge)
import Graph.Node as Node exposing (Node)
import Test exposing (..)


all : Test
all =
    describe "Graph.DegreeTests"
        [ testAllOutgoing
        , testAllIncoming
        , testAllDegrees
        , testTopDegrees
        ]


testAllOutgoing : Test
testAllOutgoing =
    List.map testOutgoing
        [ ( a, 1 )
        , ( b, 2 )
        , ( c, 0 )
        , ( d, 0 )
        ]
        |> describe "Graph.DegreeTests.Outgoing.all"


testAllIncoming : Test
testAllIncoming =
    List.map testIncoming
        [ ( a, 0 )
        , ( b, 1 )
        , ( c, 1 )
        , ( d, 1 )
        ]
        |> describe "Graph.DegreeTests.Incoming.all"


testOutgoing : ( Node, Degree ) -> Test
testOutgoing ( node, expectedDegree ) =
    test
        ("Graph.DegreeTests.testOutgoing "
            ++ node.identifier
        )
    <|
        \() ->
            Degree.outgoing dummyGraph node.identifier
                |> Expect.equal expectedDegree


testIncoming : ( Node, Degree ) -> Test
testIncoming ( node, expectedDegree ) =
    test
        ("Graph.DegreeTests.testIncoming "
            ++ node.identifier
        )
    <|
        \() ->
            Degree.incoming dummyGraph node.identifier
                |> Expect.equal expectedDegree


testAllDegrees : Test
testAllDegrees =
    test "Graph.DegreeTests.testAllDegrees" <|
        \() ->
            Degree.allDegrees dummyGraph
                |> Expect.equal
                    (Dict.fromList
                        [ ( "a", { incoming = 0, outgoing = 1 } )
                        , ( "b", { incoming = 1, outgoing = 2 } )
                        , ( "c", { incoming = 1, outgoing = 0 } )
                        , ( "d", { incoming = 1, outgoing = 0 } )
                        ]
                    )


testTopDegrees : Test
testTopDegrees =
    test "Graph.DegreeTests.testTopDegrees" <|
        \() ->
            Degree.topDegrees dummyGraph
                |> Expect.equal
                    { incoming =
                        [ ( "b", { incoming = 1, outgoing = 2 } )
                        , ( "c", { incoming = 1, outgoing = 0 } )
                        , ( "d", { incoming = 1, outgoing = 0 } )
                        , ( "a", { incoming = 0, outgoing = 1 } )
                        ]
                    , outgoing =
                        [ ( "b", { incoming = 1, outgoing = 2 } )
                        , ( "a", { incoming = 0, outgoing = 1 } )
                        , ( "c", { incoming = 1, outgoing = 0 } )
                        , ( "d", { incoming = 1, outgoing = 0 } )
                        ]
                    }


a : Node
a =
    Node "a" [ "a" ]


b : Node
b =
    Node "b" [ "b" ]


c : Node
c =
    Node "c" [ "c" ]


d : Node
d =
    Node "d" [ "d" ]


dummyNodes : List Node
dummyNodes =
    [ a, b, c, d ]


dummyEdges : List Edge
dummyEdges =
    [ Edge "a" "b", Edge "b" "c", Edge "b" "d" ]


dummyGraph : Graph Node
dummyGraph =
    Graph dummyEdges dummyNodes

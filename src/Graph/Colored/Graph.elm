module Graph.Colored.Graph exposing (ColoredGraph, decode, encode)

{-| A Graph generally allows different types of Nodes to be used. This module
provides a type alias for Graphs of Colored Nodes.

@docs ColoredGraph

## JSON

@docs encode, decode
-}

import Graph exposing (Graph)
import Graph.Colored.Node as ColoredNode exposing (Colored)
import Graph.Edge.Json as Edge
import Graph.Node exposing (Node)
import Json.Decode as JD exposing (Decoder)
import Json.Decode.Extra exposing ((|:))
import Json.Encode as JE exposing (Value)


{-| Describes a graph consisting of Colored Nodes.

See Graph.Colored.Node.
-}
type alias ColoredGraph =
    Graph (Colored Node)


{-| Decode a ColoredGraph from JSON.
-}
decode : Decoder ColoredGraph
decode =
    JD.succeed Graph
        |: JD.field "edges" (JD.list Edge.decode)
        |: JD.field "nodes" (JD.list ColoredNode.decode)


{-| Encode a ColoredGraph to JSON.
-}
encode : ColoredGraph -> Value
encode record =
    JE.object
        [ ( "edges", JE.list (List.map Edge.encode record.edges) )
        , ( "nodes", JE.list (List.map ColoredNode.encode record.nodes) )
        ]

module Graph.Json exposing (decode, encode)

{-| JSON encoding and decoding of the graph is close to the JSON representation
in sigmajs.org to allow easier intergration.

@docs decode, encode
-}

import Graph exposing (Graph)
import Graph.Edge.Json as Edge
import Graph.Node as Node exposing (Node)
import Graph.Node.Json as Node
import Json.Decode as JD exposing (Decoder)
import Json.Decode.Extra exposing ((|:))
import Json.Encode as JE exposing (Value)


{-| A decoder for `Graph Node`.
-}
decode : Decoder (Graph Node)
decode =
    JD.succeed Graph
        |: JD.field "edges" (JD.list Edge.decode)
        |: JD.field "nodes" (JD.list Node.decode)


{-| Encode `Graph Node`.
-}
encode : Graph Node -> Value
encode record =
    JE.object
        [ ( "edges", JE.list (List.map Edge.encode record.edges) )
        , ( "nodes", JE.list (List.map Node.encode record.nodes) )
        ]

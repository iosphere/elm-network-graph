module Graph.Node.Json exposing (decode, encode)

{-| JSON encoding and decoding of nodes is close to the JSON representation in
sigmajs.org to allow easier intergration.

@docs decode, encode
-}

import Graph.Node exposing (Node)
import Json.Decode as JD exposing (Decoder)
import Json.Decode.Extra exposing ((|:))
import Json.Encode as JE exposing (Value)


{-| Decodes JSON into a Node record.
-}
decode : Decoder Node
decode =
    JD.succeed Node
        |: JD.field "id" JD.string
        |: JD.field "name" (JD.list JD.string)


{-| Encodes a Node record as JSON.
-}
encode : Node -> Value
encode record =
    JE.object
        [ ( "id", JE.string record.identifier )
        , ( "name", JE.list (List.map JE.string record.name) )
        ]

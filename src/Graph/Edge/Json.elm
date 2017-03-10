module Graph.Edge.Json exposing (decode, encode)

{-| JSON encoding and decoding of edges is a subset of the JSON representation
in sigmajs.org to allow easier intergration.

@docs decode, encode
-}

import Graph.Edge exposing (Edge)
import Json.Decode as JD exposing (Decoder)
import Json.Decode.Extra exposing ((|:))
import Json.Encode as JE exposing (Value)


{-| Decodes JSON into an Edge record.
-}
decode : Decoder Edge
decode =
    JD.succeed Edge
        |: JD.field "source" JD.string
        |: JD.field "target" JD.string


{-| Encodes an Edge record as JSON.
-}
encode : Edge -> Value
encode record =
    JE.object
        [ ( "id", JE.string <| record.from ++ "<->" ++ record.to )
        , ( "source", JE.string record.from )
        , ( "target", JE.string record.to )
        ]

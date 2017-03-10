module Graph.Colored.Node exposing (Colored, decode, encode, fromNode)

{-| An extensible record that we use to add color to other record types
(see Graph.Node).

@docs Colored, fromNode

## JSON

@docs encode, decode
-}

import Graph.Colored.Color exposing (Color)
import Graph.Node as Node exposing (Node)
import Json.Encode as JE exposing (Value)
import Json.Decode as JD exposing (Decoder)
import Json.Decode.Extra exposing ((|:))


{-| Describes a record that is extended by a color field.
-}
type alias Colored a =
    { a
        | color : Color
    }


{-| Create a colored node from an uncolored node using a color.
-}
fromNode : Node -> Color -> Colored Node
fromNode node color =
    init color node.identifier node.name


init : Color -> Node.Identifier -> List String -> Colored Node
init color identifier name =
    { color = color
    , identifier = identifier
    , name = name
    }


{-| Decode a Colored Node from JSON.
-}
decode : Decoder (Colored Node)
decode =
    JD.succeed init
        |: JD.field "color" JD.string
        |: JD.field "id" JD.string
        |: JD.field "name" (JD.list JD.string)


{-| Encode a Colored Node to JSON.
-}
encode : Colored Node -> Value
encode record =
    JE.object
        [ ( "color", JE.string record.color )
        , ( "id", JE.string record.identifier )
        , ( "name", JE.list (List.map JE.string record.name) )
        ]

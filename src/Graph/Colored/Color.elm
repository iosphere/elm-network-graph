module Graph.Colored.Color exposing (Color, ColorDict, fallback, list)

{-| Color can be used to better visualize a graph.

@docs Color, ColorDict, fallback, list
-}

import Dict exposing (Dict)
import Graph.Node


{-| Color is a type alias for String to improve function signatures.
-}
type alias Color =
    String


{-| ColorDict is a look-up table for colors.
-}
type alias ColorDict =
    Dict Graph.Node.Name Color


{-| A fallback color in case you cannot find a color in your ColorDict.
-}
fallback : Color
fallback =
    "#f00"


{-| List of decent colors.

see https://material.io/guidelines/style/color.html#color-color-palette
-}
list : List Color
list =
    [ "#F44336"
    , "#E91E63"
    , "#9C27B0"
    , "#673AB7"
    , "#3F51B5"
    , "#2196F3"
    , "#03A9F4"
    , "#00BCD4"
    , "#009688"
    , "#4CAF50"
    , "#8BC34A"
    , "#FF9800"
    ]

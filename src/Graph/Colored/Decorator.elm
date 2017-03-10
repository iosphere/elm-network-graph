module Graph.Colored.Decorator exposing (coloredGraph)

{-| This decorator helps you annotate a graph with colors.

@docs coloredGraph
-}

import Dict exposing (Dict)
import Graph exposing (Graph)
import Graph.Colored.Color as Color exposing (Color, ColorDict)
import Graph.Colored.Node as ColoredNode exposing (Colored)
import Graph.Node as Node exposing (Node)
import List.Extra as List
import Set


{-| Create a Graph with colored nodes from a graph of simple nodes. The colors
will be determined based on the node names (each being a list of strings). The
first parameter (depth) determines how many name components will form a group.

Let assume a graph with the following nodes:

    Node A
    Node B
    Node B.1
    Node B.2

For depth 1 every top level node name will get its own color: B, B.1 and B.2
will have the same color, A will have a different color. For depth 2 all nodes
will have different colors.

This function returns the ColorDict along with the new graph. The color dict is
a look up table for the identifying parts of a name that determine a color.

In our example above for depth 1 that will be: `{ A: "color1", B: "color2" }`.
This can be used to create legends.
-}
coloredGraph : Int -> Graph Node -> ( ColorDict, Graph (Colored Node) )
coloredGraph depth uncoloredGraph =
    let
        strictlyPositiveDepth =
            max 1 depth

        moduleNames =
            List.map .name uncoloredGraph.nodes

        moduleColors =
            colors strictlyPositiveDepth moduleNames

        coloredNodes =
            List.map (coloredNode strictlyPositiveDepth moduleColors) uncoloredGraph.nodes
    in
        ( moduleColors
        , Graph uncoloredGraph.edges coloredNodes
        )


colors : Int -> List (List String) -> ColorDict
colors depth moduleNames =
    let
        topModuleNames =
            List.map (Node.namePrefix depth) moduleNames
                |> Set.fromList
                |> Set.toList
                |> List.sort

        allColors =
            Color.list

        colorsLength =
            List.length allColors

        colorsForModuleNames =
            topModuleNames
                |> List.indexedMap
                    (\index name ->
                        List.getAt (index % colorsLength) allColors
                            |> Maybe.withDefault Color.fallback
                            |> (,) name
                    )
    in
        Dict.fromList colorsForModuleNames


coloredNode : Int -> ColorDict -> Node -> Colored Node
coloredNode depth colors node =
    Dict.get (Node.namePrefix depth node.name) colors
        |> Maybe.withDefault Color.fallback
        |> ColoredNode.fromNode node

module Graph
    exposing
        ( Graph
        , empty
        , filter
        , filterByName
        , init
        )

{-| A network graph consists of a list of nodes connected by edges.

## Types

@docs Graph

## Constructors

@docs init, empty

## Filtering

@docs filter, filterByName
-}

import Graph.Edge as Edge exposing (Edge)
import Graph.Node as Node exposing (Node)
import Set


{-| A network graph consists of a list of nodes connected by edges.

The node type of the Graph is abstract to allow you to use records extending the
type Node. Most functions provided by this work with `Graph Node`.
-}
type alias Graph node =
    { edges : List Edge
    , nodes : List node
    }


{-| Creates an empty graph without edges or nodes.
-}
empty : Graph Node
empty =
    init [] []


{-| Initialize a node from a list of edges (see Edge) and nodes (see Node).
-}
init : List Edge -> List Node -> Graph Node
init =
    Graph


{-|
Filters a list of edges to only include edges
referencing nodes in the given list.
-}
filterEdgesForNodes : List Edge -> List Node -> List Edge
filterEdgesForNodes edges nodes =
    let
        identifiers =
            List.map .identifier nodes
                |> Set.fromList
    in
        Edge.filterForIdentifiers identifiers edges


{-| Filters a graph such that only nodes passing the test are included.
-}
filter : (Node -> Bool) -> Graph Node -> Graph Node
filter filterBy graph =
    let
        filteredNodes =
            List.filter filterBy graph.nodes

        filteredEdges =
            filterEdgesForNodes graph.edges filteredNodes
    in
        Graph filteredEdges filteredNodes


{-| Filter by name to include only nodes that start with the
specified name prefix.
-}
filterByName : Node.Name -> Graph Node -> Graph Node
filterByName namesPrefix =
    let
        filterBy node =
            -- check if the name starts with
            -- the same list of strings as the query parameter
            (List.take (List.length namesPrefix) node.name) == namesPrefix
    in
        filter filterBy

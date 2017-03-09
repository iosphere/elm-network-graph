module Graph.Edge exposing (Edge, filterForIdentifiers)

{-| An edge connects two nodes in a graph. Edges are designed to work with the
type Node. You may however use an extensible record to add fields to Node
without breaking the Edge implementation.

@docs Edge, filterForIdentifiers
-}

import Graph.Node as Node exposing (Node)
import Set exposing (Set)


{-| Describes the link between two nodes in a Graph.
-}
type alias Edge =
    { from : Node.Identifier
    , to : Node.Identifier
    }


{-| Filter list of edges to only include edges referencing a node in the
given list. This is useful to exclude external nodes that might have been
accidentally referenced.
-}
filterForIdentifiers : Set Node.Identifier -> List Edge -> List Edge
filterForIdentifiers identifiers =
    List.filter
        (\edge ->
            Set.member edge.to identifiers
                && Set.member edge.from identifiers
        )

module Graph.Degree
    exposing
        ( Degree
        , InOut
        , allDegrees
        , incoming
        , outgoing
        , topDegrees
        )

{-| This module provides functions to calculate the degrees of nodes in a graph.

* outdegree: number of outgoing edges
* indegree: number of incoming edges

## Types

@docs Degree, InOut

## Functions

@docs allDegrees, incoming, outgoing, topDegrees
-}

import Graph exposing (Graph)
import Graph.Edge exposing (Edge)
import Graph.Node as Node exposing (Node)
import Dict exposing (Dict)


{-| The degree of a node in a graph is the number of edges incident to it.

See https://en.wikipedia.org/wiki/Vertex_(graph_theory)
-}
type alias Degree =
    Int


{-| Encapsulates information about incoming and outgoing degrees.
-}
type alias InOut a =
    { incoming : a
    , outgoing : a
    }


{-| Get the outgoing degree of a node in a graph.
-}
outgoing : Graph node -> Node.Identifier -> Degree
outgoing graph identifier =
    List.filter (\edge -> edge.from == identifier) graph.edges
        |> List.length


{-| Get the incoming degree of a node in a graph.
-}
incoming : Graph node -> Node.Identifier -> Degree
incoming graph identifier =
    List.filter (\edge -> edge.to == identifier) graph.edges
        |> List.length


{-| Get a dictionary of all degrees (incoming and outgoing) for all nodes in a
 graph.
-}
allDegrees : Graph node -> Dict Node.Identifier (InOut Degree)
allDegrees graph =
    List.foldl (\edge dict -> updateDegrees graph.edges edge dict) Dict.empty graph.edges


{-| Get a list of all top inbound and outbound nodes with their respective
InOut Degrees. The lists are sorting descending by the degree (fallback
alphabetically by identifier).
-}
topDegrees : Graph node -> InOut (List ( Node.Identifier, InOut Degree ))
topDegrees graph =
    let
        degreesList =
            allDegrees graph
                |> Dict.toList

        topIn =
            List.sortWith (compareDegreesDictTuple .incoming) degreesList
                |> List.reverse

        topOut =
            List.sortWith (compareDegreesDictTuple .outgoing) degreesList
                |> List.reverse
    in
        InOut topIn topOut


compareDegreesDictTuple : (InOut Degree -> Degree) -> ( Node.Identifier, InOut Degree ) -> ( Node.Identifier, InOut Degree ) -> Basics.Order
compareDegreesDictTuple sortByField ( identifierA, degreesA ) ( identifierB, degreesB ) =
    let
        degreeCompare =
            compare (sortByField degreesA) (sortByField degreesB)
    in
        if degreeCompare == EQ then
            -- This function is primarily used in the topDegrees function where
            -- we sort descending by the degree field selected above.
            -- The sorting by name however should be alphabetically ascending,
            -- hence we invert the arguments here.
            compare identifierB identifierA
        else
            degreeCompare


updateDegrees : List Edge -> Edge -> Dict Node.Identifier (InOut Degree) -> Dict Node.Identifier (InOut Degree)
updateDegrees allEdges edge dict =
    let
        fromDegree =
            degreesInDict dict edge.from

        toDegree =
            degreesInDict dict edge.to

        updatedFromDegree =
            { fromDegree | outgoing = fromDegree.outgoing + 1 }

        updatedToDegree =
            { toDegree | incoming = toDegree.incoming + 1 }
    in
        Dict.insert edge.from updatedFromDegree dict
            |> Dict.insert edge.to updatedToDegree


degreesInDict : Dict Node.Identifier (InOut Degree) -> Node.Identifier -> InOut Degree
degreesInDict dict identifier =
    Dict.get identifier dict
        |> Maybe.withDefault (InOut 0 0)

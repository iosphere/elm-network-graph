module Graph.Node
    exposing
        ( Node
        , Identifier
        , Name
        , dictFromList
        , fromName
        , identifierFromName
        , namePrefix
        )

{-| Node describes a node in a network graph. A Node is identified
by `.identifier` which is used by Edge to reference two connected nodes.

The node's name is a list of strings to allow you to represent paths
(e.g. for modules).

## Types

@docs Node, Identifier, Name

## Constructor

@docs fromName

## Other
@docs namePrefix, identifierFromName, dictFromList
-}

import Dict exposing (Dict)


{-| A simple type alias for String to make function signatures easier readable.
-}
type alias Identifier =
    String


{-| A node's name is a list of strings to allow
you to represent paths (e.g. for modules).
-}
type alias Name =
    List String


{-| Describes a node in a graph.
-}
type alias Node =
    { identifier : Identifier
    , name : Name
    }


{-| Create a node from a name using. An identifier will be created
automatically. Use this function if all nodes in your graph have unique names.
-}
fromName : Name -> Node
fromName name =
    { identifier = identifierFromName name
    , name = name
    }


{-| Returns the first *n* members of a name.
-}
namePrefix : Int -> Name -> Name
namePrefix n name =
    List.take n name


{-| Create an identifier from a name. This is only useful if you expect names to
be unique in your graph.
-}
identifierFromName : Name -> Identifier
identifierFromName name =
    String.join "-" name


{-|
Get a dictionary to look up nodes for identifiers.
-}
dictFromList : List Node -> Dict Identifier Node
dictFromList nodes =
    List.foldl (\node dict -> Dict.insert node.identifier node dict) Dict.empty nodes

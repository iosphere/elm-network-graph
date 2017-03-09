module Graph.Node
    exposing
        ( Node
        , Identifier
        , Name
        , fromName
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
@docs namePrefix
-}


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


{-| -}
identifierFromName : Name -> Identifier
identifierFromName name =
    String.join "-" name
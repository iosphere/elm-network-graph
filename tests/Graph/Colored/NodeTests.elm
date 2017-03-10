module Graph.Colored.NodeTests exposing (all)

import Test exposing (..)
import Expect
import Graph.Node as Node exposing (Node)
import Graph.Colored.Node as ColoredNode exposing (Colored)
import Json.Decode as JD
import Json.Encode as JE


all : Test
all =
    describe "Graph.Colored.Node"
        [ testDecoder, testEncoder ]


testDecoder : Test
testDecoder =
    test "Graph.Colored.Node.decode" <|
        \() ->
            Result.Ok (testNode)
                |> Expect.equal (JD.decodeString ColoredNode.decode jsonStringNode)


testEncoder : Test
testEncoder =
    test "Graph.Colored.Node.encode" <|
        \() ->
            Expect.equal (JE.encode 0 (ColoredNode.encode testNode)) jsonStringNode


testNode : Colored Node
testNode =
    ColoredNode.fromNode (Node "ident" [ "testName" ]) "red"


jsonStringNode : String
jsonStringNode =
    """{"color":"red","id":"ident","name":["testName"]}"""

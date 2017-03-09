module Tests exposing (all)

import Test exposing (Test)
import Graph.Tests
import Graph.GraphVizTests


all : Test
all =
    Test.concat
        [ Graph.Tests.all
        , Graph.GraphVizTests.all
        ]

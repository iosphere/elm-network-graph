module Tests exposing (all)

import Graph.Colored.NodeTests
import Graph.GraphVizTests
import Graph.Tests
import Test exposing (Test)
import Graph.DegreeTests


all : Test
all =
    Test.concat
        [ Graph.Colored.NodeTests.all
        , Graph.DegreeTests.all
        , Graph.GraphVizTests.all
        , Graph.Tests.all
        ]

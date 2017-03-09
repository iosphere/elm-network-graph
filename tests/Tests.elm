module Tests exposing (all)

import Test exposing (Test)
import Graph.Tests


all : Test
all =
    Test.concat
        [ Graph.Tests.all
        ]

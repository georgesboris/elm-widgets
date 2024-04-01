module Chapters.Core.Heading exposing (..)

import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import Html as H
import Html.Attributes as HA
import Theme
import W.Heading
import W.Text
import W.Container


chapter_ : Chapter x
chapter_ =
    chapter "Heading & Text"
        |> renderComponentList
            [ ( "W.Heading"
              , H.div []
                    [ W.Heading.view
                        [ W.Heading.extraLarge ]
                        [ H.text "Heading XL" ]
                    , W.Heading.view
                        [ W.Heading.large ]
                        [ H.text "Heading L" ]
                    , W.Heading.view []
                        [ H.text "Heading" ]
                    , W.Heading.view
                        [ W.Heading.small ]
                        [ H.text "Heading S" ]
                    , W.Heading.view
                        [ W.Heading.extraSmall ]
                        [ H.text "Heading XS" ]
                    ]
              )
            , ( "W.Text"
              , H.div []
                    [ W.Text.view
                        [ W.Text.extraLarge, W.Text.aux ]
                        [ H.text "Text XL" ]
                    , W.Text.view
                        [ W.Text.large, W.Text.aux ]
                        [ H.text "Text L" ]
                    , W.Text.view [ W.Text.aux ]
                        [ H.text "Text" ]
                    , W.Text.view
                        [ W.Text.small, W.Text.aux ]
                        [ H.text "Text S" ]
                    , W.Text.view
                        [ W.Text.extraSmall, W.Text.aux ]
                        [ H.text "Text XS" ]
                    ]
              )
            , ( "Compositions"
              , H.div []
                    [ W.Container.view
                        [ W.Container.padBottom_4 ]
                        [ W.Heading.view
                            [ W.Heading.extraLarge ]
                            [ H.text "I'm a XL title" ]
                        , W.Text.view
                            [ W.Text.extraLarge, W.Text.aux ]
                            [ H.text "I'm a extra large text" ]
                        ]
                       , W.Container.view
                            [ W.Container.padBottom_4 ]
                            [ W.Heading.view
                                [ W.Heading.h2
                                , W.Heading.large
                                ]
                                [ H.text "I'm a large title" ]
                            , W.Text.view
                                [ W.Text.large, W.Text.aux ]
                                [ H.text "I'm a large text" ]
                            ]
                       , W.Container.view
                            [ W.Container.padBottom_4 ]
                            [ W.Heading.view []
                                [ H.text "I'm the base title" ]
                            , W.Text.view [ W.Text.aux ]
                                [ H.text "I'm the base text" ]
                            ]
                       , W.Container.view
                            [ W.Container.padBottom_4 ]
                            [ W.Heading.view
                                [ W.Heading.small ]
                                [ H.text "I'm a small title" ]
                            , W.Text.view
                                [ W.Text.small, W.Text.aux ]
                                [ H.text "I'm a small text" ]
                            ]
                       , W.Container.view
                            [ W.Container.padBottom_4 ]
                            [ W.Heading.view
                                [ W.Heading.extraSmall ]
                                [ H.text "I'm a extra small title" ]
                            , W.Text.view
                                [ W.Text.extraSmall, W.Text.aux ]
                                [ H.text "I'm a extra small text" ]
                            ]
                    ]
                )
            ]

module W.Badge exposing
    ( view, viewInline
    , neutral, primary, secondary, success, warning, color, background
    , small
    , htmlAttrs, noAttr, Attribute
    )

{-| Badges are commonly used to display notifications.

@docs view, viewInline


# Colors

By default, badges appear in a **danger** color.

@docs neutral, primary, secondary, success, warning, color, background


# Styles

@docs small


# Html

@docs htmlAttrs, noAttr, Attribute

-}

import Html as H
import Html.Attributes as HA
import W.Theme



-- Attributes


{-| -}
type Attribute msg
    = Attribute (Attributes msg -> Attributes msg)


type alias Attributes msg =
    { htmlAttributes : List (H.Attribute msg)
    , small : Bool
    , color : String
    , background : String
    }


applyAttrs : List (Attribute msg) -> Attributes msg
applyAttrs attrs =
    List.foldl (\(Attribute fn) a -> fn a) defaultAttrs attrs


defaultAttrs : Attributes msg
defaultAttrs =
    { htmlAttributes = []
    , small = False
    , color = W.Theme.danger.solidText
    , background = W.Theme.danger.solid
    }



-- Attributes : Setters


{-| -}
htmlAttrs : List (H.Attribute msg) -> Attribute msg
htmlAttrs v =
    Attribute <| \attrs -> { attrs | htmlAttributes = v }


{-| -}
noAttr : Attribute msg
noAttr =
    Attribute identity


{-| -}
small : Attribute msg
small =
    Attribute <| \attrs -> { attrs | small = True }


{-| -}
color : String -> Attribute msg
color v =
    Attribute <| \attrs -> { attrs | color = v }


{-| -}
background : String -> Attribute msg
background v =
    Attribute <| \attrs -> { attrs | background = v }


{-| -}
neutral : Attribute msg
neutral =
    Attribute <|
        \attrs ->
            { attrs
                | background = W.Theme.base.solid
                , color = W.Theme.base.solidText
            }


{-| -}
primary : Attribute msg
primary =
    Attribute <|
        \attrs ->
            { attrs
                | background = W.Theme.primary.solid
                , color = W.Theme.primary.solidText
            }


{-| -}
secondary : Attribute msg
secondary =
    Attribute <|
        \attrs ->
            { attrs
                | background = W.Theme.secondary.solid
                , color = W.Theme.secondary.solidText
            }


{-| -}
success : Attribute msg
success =
    Attribute <|
        \attrs ->
            { attrs
                | background = W.Theme.success.solid
                , color = W.Theme.success.solidText
            }


{-| -}
warning : Attribute msg
warning =
    Attribute <|
        \attrs ->
            { attrs
                | background = W.Theme.warning.solid
                , color = W.Theme.warning.solidText
            }



-- Main


{-|

    W.Badge.view []
        { -- number of unread messages
          content = Just [ H.text "9" ]
        , -- call to action
          children =
            [ W.Button.viewLink []
                { href = "/messages"
                , label = [ H.text "Messages" ]
                }
            ]
        }

-}
view :
    List (Attribute msg)
    ->
        { content : Maybe (List (H.Html msg))
        , children : List (H.Html msg)
        }
    -> H.Html msg
view attrs_ props =
    let
        badge : H.Html msg
        badge =
            case props.content of
                Just content ->
                    let
                        attrs : Attributes msg
                        attrs =
                            applyAttrs attrs_
                    in
                    H.span
                        (baseAttrs attrs
                            ++ [ HA.class "ew-absolute ew-bottom-full ew-left-full"
                               , HA.class "-ew-mb-2.5 -ew-ml-2.5"
                               , HA.class "ew-animate-fade-slide"
                               ]
                        )
                        content

                Nothing ->
                    H.text ""
    in
    H.span []
        [ H.span
            [ HA.class "ew-relative" ]
            (badge :: props.children)
        ]


{-|

    W.Badge.viewInline [] [ H.text "9" ]

-}
viewInline : List (Attribute msg) -> List (H.Html msg) -> H.Html msg
viewInline attrs_ value =
    let
        attrs : Attributes msg
        attrs =
            applyAttrs attrs_
    in
    H.span (baseAttrs attrs) value


baseAttrs : Attributes msg -> List (H.Attribute msg)
baseAttrs attrs =
    attrs.htmlAttributes
        ++ [ HA.class "ew-rounded-full ew-flex ew-items-center ew-justify-center"
           , HA.class "ew-leading-none ew-font-semibold"
           , HA.class "ew-shadow"
           , HA.classList
                [ ( "ew-px-2.5 ew-h-6 ew-text-sm", not attrs.small )
                , ( "ew-px-1.5 ew-h-4 ew-text-xs", attrs.small )
                ]
           , W.Theme.styleListIf
                [ ( "color", attrs.color, True )
                , ( "background", attrs.background, True )
                , ( "min-width", "5px", attrs.small )
                ]
           ]

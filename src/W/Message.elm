module W.Message exposing
    ( view
    , icon, footer
    , primary, secondary, success, warning, danger, theme
    , href, onClick
    , htmlAttrs, noAttr, Attribute
    )

{-|

@docs view


# Content

@docs icon, footer


# Styles

@docs primary, secondary, success, warning, danger, theme


# Actions

@docs href, onClick


# Html

@docs htmlAttrs, noAttr, Attribute

-}

import Html as H
import Html.Attributes as HA
import Html.Events as HE
import W.Internal.Helpers as WH
import W.Theme



-- Attributes


{-| -}
type Attribute msg
    = Attribute (Attributes msg -> Attributes msg)


type alias Attributes msg =
    { htmlAttributes : List (H.Attribute msg)
    , icon : Maybe (List (H.Html msg))
    , footer : Maybe (List (H.Html msg))
    , theme : { text : String, solid : String, tint : String }
    , href : Maybe String
    , onClick : Maybe msg
    }


applyAttrs : List (Attribute msg) -> Attributes msg
applyAttrs attrs =
    List.foldl (\(Attribute fn) a -> fn a) defaultAttrs attrs


defaultAttrs : Attributes msg
defaultAttrs =
    { htmlAttributes = []
    , icon = Nothing
    , footer = Nothing
    , theme = toTheme W.Theme.base
    , href = Nothing
    , onClick = Nothing
    }


toTheme : { a | text : String, solid : String, tint : String } -> { text : String, solid : String, tint : String }
toTheme t =
    { text = t.text
    , solid = t.solid
    , tint = t.tint
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
onClick : msg -> Attribute msg
onClick v =
    Attribute <| \attrs -> { attrs | onClick = Just v }


{-| -}
href : String -> Attribute msg
href v =
    Attribute <| \attrs -> { attrs | href = Just v }


{-| -}
icon : List (H.Html msg) -> Attribute msg
icon v =
    Attribute <| \attrs -> { attrs | icon = Just v }


{-| -}
footer : List (H.Html msg) -> Attribute msg
footer v =
    Attribute <| \attrs -> { attrs | footer = Just v }


{-| -}
theme : { a | text : String, solid : String, tint : String } -> Attribute msg
theme v =
    Attribute <| \attrs -> { attrs | theme = toTheme v }


{-| -}
primary : Attribute msg
primary =
    Attribute <|
        \attrs ->
            { attrs | theme = toTheme W.Theme.primary }


{-| -}
secondary : Attribute msg
secondary =
    Attribute <|
        \attrs ->
            { attrs | theme = toTheme W.Theme.secondary }


{-| -}
success : Attribute msg
success =
    Attribute <|
        \attrs ->
            { attrs | theme = toTheme W.Theme.success }


{-| -}
warning : Attribute msg
warning =
    Attribute <|
        \attrs ->
            { attrs | theme = toTheme W.Theme.warning }


{-| -}
danger : Attribute msg
danger =
    Attribute <|
        \attrs ->
            { attrs | theme = toTheme W.Theme.danger }



-- Main


{-| -}
view :
    List (Attribute msg)
    -> List (H.Html msg)
    -> H.Html msg
view attrs_ children_ =
    let
        attrs : Attributes msg
        attrs =
            applyAttrs attrs_

        baseAttrs : List (H.Attribute msg)
        baseAttrs =
            attrs.htmlAttributes
                ++ [ HA.class "ew-m-0 ew-box-border ew-relative"
                   , HA.class "ew-flex ew-gap-4 ew-w-full"
                   , HA.class "ew-text-base ew-font-medium"
                   , HA.class "ew-py-2 ew-px-4 ew-pr-6"
                   , HA.class "ew-rounded"
                   , HA.class "ew-border-l-[6px] ew-border-0 ew-border-solid ew-border-current"
                   , HA.class "before:ew-block before:ew-content-['']"
                   , HA.class "before:ew-absolute before:ew-inset-0 ew-z-0"
                   , HA.class "before:ew-rounded-r before:ew-bg-current before:ew-opacity-[0.07]"
                   , W.Theme.styleList
                        [ ( "font-family", W.Theme.font.text )
                        , ( "background", W.Theme.base.bg )
                        , ( "color", attrs.theme.solid )
                        ]
                   ]

        children : List (H.Html msg)
        children =
            [ WH.maybeHtml (\i -> H.div [] i) attrs.icon
            , H.div [ HA.class "ew-flex ew-flex-col" ]
                [ H.div [] children_
                , WH.maybeHtml (H.div [ HA.class "ew-text-sm ew-font-normal" ]) attrs.footer
                ]
            ]
    in
    case ( attrs.onClick, attrs.href ) of
        ( Just onClick_, _ ) ->
            H.button
                (baseAttrs ++ [ interactiveClass, HE.onClick onClick_ ])
                children

        ( Nothing, Just href_ ) ->
            H.a
                (baseAttrs ++ [ interactiveClass, HA.href href_ ])
                children

        _ ->
            H.div baseAttrs children


interactiveClass : H.Attribute msg
interactiveClass =
    HA.class
        "ew-appearance-none ew-bg-transparent ew-no-underline ew-focusable-outline hover:before:ew-opacity-[0.05] active:before:ew-opacity-[0.03]"

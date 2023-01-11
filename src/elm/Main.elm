module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (alt, attribute, class, height, href, id, media, src, target, width)
import Html.Events exposing (onClick, onSubmit)


main : Program () Model Msg
main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }



--** SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



--** MODEL


type alias Model =
    {}



--** INIT


init : () -> ( Model, Cmd msg )
init _ =
    ( {}, Cmd.none )



--** UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    ( model, Cmd.none )



--** VIEW


view : Model -> Html Msg
view model =
    div [ id "root" ]
        [ header [ class "header" ]
            [ h1 [ class "sr-only" ] [ text "Interactive Card Details Form" ]
            ]
        , div [ class "wrapper" ]
            -- card as in credit card, not a card component, thus no base card class
            [ div [ class "card-image" ]
                [ picture []
                    [ source [ media "(min-width: 48em)", attribute "srcset" "./images/bg-main-desktop.png", width 483, height 900 ] []
                    , source [ media "(min-width: 23.4375em)", attribute "srcset" "./images/bg-main-mobile.png", width 375, height 240 ] []
                    , img [ src "./images/bg-main-mobile.png", alt "" ] []
                    ]
                ]
            , div [ class "card-form" ]
                [ img [ src "./images/bg-card-front.png" ] []
                ]
            ]
        , footer [ class "attribution" ]
            [ p []
                [ text "Challenge by "
                , a [ href "https://www.frontendmentor.io?ref=challenge", target "_blank" ] [ text "Frontend Mentor" ]
                , text "Coded by "
                , a [ href "https://github.com/DanielArzani", target "_blank" ] [ text "Daniel Arzanipour" ]
                ]
            ]
        ]



-- picture element doesn't exist as of yet so this is a replacement


picture : List (Html.Attribute msg) -> List (Html msg) -> Html msg
picture =
    Html.node "picture"



--** VIEW FUNCTIONS
--** HELPER FUNCTIONS

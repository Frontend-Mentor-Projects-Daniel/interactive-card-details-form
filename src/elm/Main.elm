module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (class, href, id, target)
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
        [ footer [ class "attribution" ]
            [ p []
                [ text "Challenge by "
                , a [ href "https://www.frontendmentor.io?ref=challenge", target "_blank" ] [ text "Frontend Mentor" ]
                , text "Coded by "
                , a [ href "https://github.com/DanielArzani", target "_blank" ] [ text "Daniel Arzanipour" ]
                ]
            ]
        ]



--** VIEW FUNCTIONS
--** HELPER FUNCTIONS

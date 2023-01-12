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
        , main_ [ class "wrapper center" ]
            -- card as in credit card, not a card component, thus no base card class
            [ div [ class "card-image" ] []
            , div [ class "card-form" ] []
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

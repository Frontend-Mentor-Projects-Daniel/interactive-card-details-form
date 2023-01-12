module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (action, alt, attribute, autocomplete, class, for, height, href, id, media, method, min, minlength, name, pattern, placeholder, required, src, target, type_, width)
import Html.Attributes.Aria exposing (ariaDescribedby, ariaLive)
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
            [ div [ class "card-image" ]
                [ div [ class "card-logo" ]
                    [ img [ src "./images/card-logo.svg", alt "" ] []
                    ]
                , span [ class "back-of-card-text" ] [ p [ class "cvc" ] [ text "000" ] ]
                , span [ class "front-of-card-text" ]
                    [ p [ class "number" ] [ text "0000 0000 0000 0000" ]
                    , p [ class "name" ] [ text "Jane Appleseed" ]
                    , p [ class "expiry-date" ] [ text "00/00" ]
                    ]
                ]
            , div [ class "card-form" ]
                [ form [ action "/", method "get" ]
                    [ fieldset [ class "fieldset--main" ]
                        [ div [ class "name" ]
                            [ label [ for "name" ] [ text "cardholder name" ]
                            , input [ type_ "text", id "name", name "name", placeholder "e.g. Jane Appleseed", required True, minlength 1, ariaDescribedby "error--name", autocomplete True ] []
                            , span [ class "error--name", id "error--name", ariaLive "polite" ] [ text "" ]
                            ]
                        , div [ class "number" ]
                            [ label [ for "number" ] [ text "card number" ]
                            , input [ type_ "text", id "number", name "number", placeholder "e.g. 1234 5678 9123 0000", required True, pattern "[0-9]{4}[ -]?[0-9]{4}[ -]?[0-9]{4}[ -]?[0-9]{4}|[0-9]{16}", ariaDescribedby "error--number" ] []
                            , span [ class "error--number", id "error--number", ariaLive "polite" ] [ text "" ]
                            ]
                        , div [ class "expiry-date-and-cvc" ]
                            [ fieldset [ class "fieldset--expiry-date" ]
                                [ legend [] [ text "exp.date (mm/yy)" ]
                                , span [ class "month" ]
                                    [ label [ for "month", class "sr-only" ] [ text "expiration date, month" ]
                                    , input [ id "month", name "month", placeholder "MM", required True, pattern "^(0[1-9]|1[0-2])$", ariaDescribedby "error--expiry-date", Html.Attributes.maxlength 3 ] []
                                    ]
                                , span [ class "year" ]
                                    [ label [ for "year", class "sr-only" ] [ text "expiration date, year" ]
                                    , input [ id "year", name "year", placeholder "YY", required True, pattern "^\\d+$", ariaDescribedby "error--expiry-date", Html.Attributes.maxlength 3 ] []
                                    ]
                                , span [ class "error--expiry-date", id "error--expiry-date", ariaLive "polite" ] [ text "" ]
                                ]
                            , span [ class "cvc" ]
                                [ label [ for "cvc" ] [ text "cvc" ]
                                , input [ id "cvc", name "cvc", placeholder "e.g. 123", required True, ariaDescribedby "error--cvc", pattern "^\\d+$", Html.Attributes.maxlength 3 ] []
                                , span [ class "error--cvc", id "error--cvc", ariaLive "polite" ] [ text "" ]
                                ]
                            ]
                        , button [ type_ "submit" ] [ text "Confirm" ]
                        ]
                    ]
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

module Main exposing (main)

import Browser
import Data exposing (ErrorMessageProps, InputProps, LabelProps, LabelWithClassProps, cvcError, cvcInput, cvcLabel, expiryError, expiryInputMonth, expiryInputYear, expiryLabelMonth, expiryLabelYear, nameError, nameInput, nameLabel, numberError, numberInput, numberLabel)
import Html exposing (..)
import Html.Attributes exposing (action, alt, autocomplete, class, for, href, id, maxlength, media, method, minlength, name, novalidate, pattern, placeholder, required, src, target, type_)
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
            -- card as in credit card, not a card component
            [ div [ class "card card-image" ]
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
            , div [ class "card card-form" ]
                [ form [ action "/", method "get", novalidate True ]
                    [ fieldset [ class "fieldset--main" ]
                        [ div [ class "name form-group" ]
                            [ viewLabel nameLabel
                            , viewInput nameInput
                            , viewError nameError
                            ]
                        , div [ class "number form-group" ]
                            [ viewLabel numberLabel
                            , viewInput numberInput
                            , viewError numberError
                            ]
                        , div [ class "form-group double-group" ]
                            [ fieldset [ class "fieldset--expiry-date" ]
                                [ legend [] [ text "exp.date (mm/yy)" ]
                                , div [ class "expiry-wrapper" ]
                                    [ span [ class "month" ]
                                        [ viewLabelWithClass expiryLabelMonth
                                        , viewInput expiryInputMonth
                                        ]
                                    , span [ class "year" ]
                                        [ viewLabelWithClass expiryLabelYear
                                        , viewInput expiryInputYear
                                        ]
                                    , viewError expiryError
                                    ]
                                ]
                            , div [ class "cvc form-group" ]
                                [ viewLabel cvcLabel
                                , viewInput cvcInput
                                , viewError cvcError
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



--** VIEW FUNCTIONS
--^ CREATE FORM CONTROLS


viewLabel : LabelProps -> Html msg
viewLabel props =
    label [ for props.for ] [ text props.text ]


viewLabelWithClass : LabelWithClassProps -> Html msg
viewLabelWithClass props =
    label [ for props.for, class props.class ] [ text props.text ]


viewInput : InputProps -> Html msg
viewInput props =
    input [ type_ props.type_, id props.id, name props.name, placeholder props.placeholder, required props.required, minlength (convertMaybeLength nameInput.minLength), maxlength (convertMaybeLength props.maxLength), ariaDescribedby props.describedby, autocomplete (convertMaybeBool props.autoComplete), pattern (convertMaybePattern props.pattern) ] []


viewError : ErrorMessageProps -> Html msg
viewError props =
    p [ class props.class, id props.id, ariaLive props.ariaLive ] [ text props.text ]



--** HELPER FUNCTIONS


convertMaybeLength : Maybe Int -> Int
convertMaybeLength param =
    case param of
        Just num ->
            num

        Nothing ->
            99


convertMaybeBool : Maybe Bool -> Bool
convertMaybeBool param =
    case param of
        Just _ ->
            True

        Nothing ->
            False


convertMaybePattern : Maybe String -> String
convertMaybePattern param =
    case param of
        Just str ->
            str

        Nothing ->
            ".*"

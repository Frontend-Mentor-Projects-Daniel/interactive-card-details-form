module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (alt, autocomplete, class, for, href, id, name, placeholder, src, target, type_)
import Html.Attributes.Aria exposing (ariaDescribedby, ariaLive)
import Html.Events exposing (onClick, onInput, onSubmit)


main : Program () Model Msg
main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }



--** SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



--** MODEL


type alias Model =
    { userCardData : FormFormat
    , currentUsername : String
    , usernameError : String
    , cardNumberError : String
    , cardExpDateError : String
    , cardCvcError : String
    }



--** TYPES


type alias FormFormat =
    { username : String
    , cardNumber : String
    , expDate : Int
    , cvc : Int
    }



--** INIT


init : () -> ( Model, Cmd msg )
init _ =
    ( { userCardData =
            { username = ""
            , cardNumber = ""
            , expDate = 0
            , cvc = 0
            }
      , currentUsername = ""
      , usernameError = ""
      , cardNumberError = ""
      , cardExpDateError = ""
      , cardCvcError = ""
      }
    , Cmd.none
    )



--** UPDATE


type Msg
    = FormSubmission
    | CurrentUsernameValue String
    | CurrentCardNumberValue String
    | CurrentExpDateMonthValue String
    | CurrentExpDateYearValue String
    | CurrentCardCvcValue String


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    ( case msg of
        FormSubmission ->
            Debug.log (Debug.toString model)
                model

        CurrentUsernameValue username ->
            if validateUsername username == True then
                { model | currentUsername = username, usernameError = "" }

            else
                { model | currentUsername = username, usernameError = "Name must be at least 1 character long" }

        CurrentCardNumberValue cardNumber ->
            model

        CurrentExpDateMonthValue expDate ->
            model

        CurrentExpDateYearValue expDate ->
            model

        CurrentCardCvcValue expDate ->
            model
    , Cmd.none
    )



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
                [ form [ onSubmit FormSubmission ]
                    [ fieldset [ class "fieldset--main" ]
                        [ div [ class "name form-group", ariaDescribedby "error--name", ariaLive "polite" ]
                            [ viewUsernameLabel
                            , viewUsernameInput
                            , viewUsernameError model
                            ]
                        , div [ class "number form-group", ariaDescribedby "error--number", ariaLive "polite" ]
                            [ viewCardNumberLabel
                            , viewCardNumberInput
                            , viewCardNumberError model
                            ]
                        , div [ class "form-group double-group" ]
                            [ fieldset [ class "fieldset--expiry-date" ]
                                [ legend [] [ text "exp.date (mm/yy)" ]
                                , div [ class "expiry-wrapper", ariaDescribedby "error--expiry-date", ariaLive "polite" ]
                                    [ span [ class "month" ]
                                        [ viewExpDateMonthLabel
                                        , viewExpDateMonthInput
                                        ]
                                    , span [ class "year" ]
                                        [ viewExpDateYearLabel
                                        , viewExpDateYearInput
                                        ]
                                    , viewExpDateError model
                                    ]
                                ]
                            , div [ class "cvc form-group", ariaDescribedby "error--cvc", ariaLive "polite" ]
                                [ viewCardCvcLabel
                                , viewCardCvcInput
                                , viewCardCvcError model
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
-- username input


viewUsernameLabel : Html msg
viewUsernameLabel =
    label [ for "name" ] [ text "cardholder name" ]


viewUsernameInput : Html Msg
viewUsernameInput =
    input [ type_ "text", id "name", name "name", placeholder "e.g. Jane Appleseed", onInput CurrentUsernameValue ] []


viewUsernameError : Model -> Html msg
viewUsernameError model =
    p [ id "error--name", class "error error--name" ] [ text model.usernameError ]



-- card number input


viewCardNumberLabel : Html msg
viewCardNumberLabel =
    label [ for "number" ] [ text "card number" ]


viewCardNumberInput : Html Msg
viewCardNumberInput =
    input
        [ type_ "text"
        , id "number"
        , name "number"
        , placeholder "e.g. 1234 5678 9123 0000"
        , onInput CurrentCardNumberValue
        ]
        []


viewCardNumberError : Model -> Html msg
viewCardNumberError model =
    p [ class "error error--number", id "error--number" ] [ text model.cardNumberError ]



-- exp date input


viewExpDateMonthLabel : Html msg
viewExpDateMonthLabel =
    label [ for "month", class "sr-only" ] [ text "expiration date, month" ]


viewExpDateMonthInput : Html Msg
viewExpDateMonthInput =
    input
        [ type_ "text"
        , id "month"
        , name "month"
        , placeholder "MM"
        , onInput CurrentExpDateMonthValue
        ]
        []


viewExpDateYearLabel : Html msg
viewExpDateYearLabel =
    label [ for "year", class "sr-only" ] [ text "expiration date, year" ]


viewExpDateYearInput : Html Msg
viewExpDateYearInput =
    input
        [ type_ "text"
        , id "year"
        , name "year"
        , placeholder "YY"
        , onInput CurrentExpDateYearValue
        ]
        []


viewExpDateError : Model -> Html msg
viewExpDateError model =
    p [ class "error error--expiry-date", id "error--expiry-date" ] [ text model.cardExpDateError ]



-- cvc input


viewCardCvcLabel : Html msg
viewCardCvcLabel =
    label [ for "cvc" ] [ text "cvc" ]


viewCardCvcInput : Html Msg
viewCardCvcInput =
    input
        [ type_ "text"
        , id "cvc"
        , name "cvc"
        , placeholder "123"
        , onInput CurrentCardCvcValue
        ]
        []


viewCardCvcError : Model -> Html msg
viewCardCvcError model =
    p [ class "error error--cvc", id "error--cvc" ] [ text model.cardCvcError ]



--** VALIDATION FUNCTIONS


validateUsername : String -> Bool
validateUsername username =
    let
        tooShort =
            if (String.length <| String.trim <| username) < 1 then
                False

            else
                True
    in
    tooShort



--** HELPER FUNCTIONS

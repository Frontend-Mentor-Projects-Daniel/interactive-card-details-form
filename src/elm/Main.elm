module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (alt, autocomplete, class, for, href, id, maxlength, minlength, name, placeholder, src, target, type_, value)
import Html.Attributes.Aria exposing (ariaDescribedby, ariaLive)
import Html.Events exposing (onInput, onSubmit)
import Regex exposing (Regex)


main : Program () Model Msg
main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }



--** SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



--** MODEL


type alias Model =
    { currentUsername : String
    , currentCardData : String
    , currentExpDateMonth : String
    , currentExpDateYear : String
    , currentCvc : String
    , usernameError : String
    , cardNumberError : String
    , cardExpDateError : String
    , cardCvcError : String
    }



--** TYPES
--** INIT


init : () -> ( Model, Cmd msg )
init _ =
    ( { currentUsername = ""
      , currentCardData = ""
      , currentExpDateMonth = ""
      , currentExpDateYear = ""
      , currentCvc = ""
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
            -- Debug.log (Debug.toString model)
            let
                canSubmit =
                    checkIfAnyErrors model && checkIfAnyEmptyStrings model
            in
            if canSubmit == True then
                { model | currentUsername = "", currentCardData = "", currentExpDateMonth = "", currentExpDateYear = "", currentCvc = "" }

            else
                model

        CurrentUsernameValue username ->
            if validateUsername username == True then
                { model | currentUsername = String.trimLeft username, usernameError = "" }

            else
                { model | currentUsername = username, usernameError = "Name must be at least 1 character long" }

        CurrentCardNumberValue cardNumber ->
            if validateCardNumber cardNumber == True then
                { model | currentCardData = cardNumber, cardNumberError = "" }

            else
                { model | currentCardData = cardNumber, cardNumberError = "Wrong format, it should resemble: xxxx xxxx xxxx xxxx" }

        CurrentExpDateMonthValue expDate ->
            if validateExpDate expDate == True then
                { model | currentExpDateMonth = expDate, cardExpDateError = "" }

            else
                { model | currentExpDateMonth = expDate, cardExpDateError = "Must be in the format of 01 - 12" }

        CurrentExpDateYearValue expDate ->
            if validateExpDate expDate == True then
                { model | currentExpDateYear = expDate, cardExpDateError = "" }

            else
                { model | currentExpDateYear = expDate, cardExpDateError = "Must be in the format of 01 - 12" }

        CurrentCardCvcValue cvc ->
            if validateCvc cvc == True then
                { model | currentCvc = cvc, cardCvcError = "" }

            else
                { model | currentCvc = cvc, cardCvcError = "Must contain 3 numbers" }
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
                            , viewUsernameInput model
                            , viewUsernameError model
                            ]
                        , div [ class "number form-group", ariaDescribedby "error--number", ariaLive "polite" ]
                            [ viewCardNumberLabel
                            , viewCardNumberInput model
                            , viewCardNumberError model
                            ]
                        , div [ class "form-group double-group" ]
                            [ fieldset [ class "fieldset--expiry-date" ]
                                [ legend [] [ text "exp.date (mm/yy)" ]
                                , div [ class "expiry-wrapper", ariaDescribedby "error--expiry-date", ariaLive "polite" ]
                                    [ span [ class "month" ]
                                        [ viewExpDateMonthLabel
                                        , viewExpDateMonthInput model
                                        ]
                                    , span [ class "year" ]
                                        [ viewExpDateYearLabel
                                        , viewExpDateYearInput model
                                        ]
                                    , viewExpDateError model
                                    ]
                                ]
                            , div [ class "cvc form-group", ariaDescribedby "error--cvc", ariaLive "polite" ]
                                [ viewCardCvcLabel
                                , viewCardCvcInput model
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
--? username input


viewUsernameLabel : Html msg
viewUsernameLabel =
    label [ for "name" ] [ text "cardholder name" ]


viewUsernameInput : Model -> Html Msg
viewUsernameInput model =
    input
        [ type_ "text"
        , id "name"
        , name "name"
        , placeholder "e.g. Jane Appleseed"
        , onInput CurrentUsernameValue
        , value model.currentUsername
        ]
        []


viewUsernameError : Model -> Html msg
viewUsernameError model =
    p [ id "error--name", class "error error--name" ] [ text model.usernameError ]



--? card number input


viewCardNumberLabel : Html msg
viewCardNumberLabel =
    label [ for "number" ] [ text "card number" ]


viewCardNumberInput : Model -> Html Msg
viewCardNumberInput model =
    input
        [ type_ "text"
        , id "number"
        , name "number"
        , placeholder "e.g. 1234 5678 9123 0000"
        , maxlength 19
        , onInput CurrentCardNumberValue
        , value model.currentCardData
        ]
        []


viewCardNumberError : Model -> Html msg
viewCardNumberError model =
    p [ class "error error--number", id "error--number" ] [ text model.cardNumberError ]



--? exp date input


viewExpDateMonthLabel : Html msg
viewExpDateMonthLabel =
    label [ for "month", class "sr-only" ] [ text "expiration date, month" ]


viewExpDateMonthInput : Model -> Html Msg
viewExpDateMonthInput model =
    input
        [ type_ "text"
        , id "month"
        , name "month"
        , placeholder "MM"
        , maxlength 2
        , value model.currentExpDateMonth
        , onInput CurrentExpDateMonthValue
        ]
        []


viewExpDateYearLabel : Html msg
viewExpDateYearLabel =
    label [ for "year", class "sr-only" ] [ text "expiration date, year" ]


viewExpDateYearInput : Model -> Html Msg
viewExpDateYearInput model =
    input
        [ type_ "text"
        , id "year"
        , name "year"
        , placeholder "YY"
        , maxlength 2
        , value model.currentExpDateYear
        , onInput CurrentExpDateYearValue
        ]
        []


viewExpDateError : Model -> Html msg
viewExpDateError model =
    p [ class "error error--expiry-date", id "error--expiry-date" ] [ text model.cardExpDateError ]



--? cvc input


viewCardCvcLabel : Html msg
viewCardCvcLabel =
    label [ for "cvc" ] [ text "cvc" ]


viewCardCvcInput : Model -> Html Msg
viewCardCvcInput model =
    input
        [ type_ "text"
        , id "cvc"
        , name "cvc"
        , placeholder "123"
        , maxlength 3
        , value model.currentCvc
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


validateCardNumber : String -> Bool
validateCardNumber cardNumber =
    Regex.contains regexCardNumber cardNumber


validateExpDate : String -> Bool
validateExpDate expDate =
    Regex.contains regexExpDate expDate


validateCvc : String -> Bool
validateCvc cvc =
    Regex.contains regexCvc cvc



--** HELPER FUNCTIONS


regexCardNumber : Regex.Regex
regexCardNumber =
    Maybe.withDefault Regex.never <|
        Regex.fromString "^[0-9]{4} [0-9]{4} [0-9]{4} [0-9]{4}$"


regexExpDate : Regex.Regex
regexExpDate =
    Maybe.withDefault Regex.never <|
        Regex.fromString "^[0-9]{2}$"


regexCvc : Regex.Regex
regexCvc =
    Maybe.withDefault Regex.never <|
        Regex.fromString "^[0-9]{3}$"


checkIfAnyErrors : Model -> Bool
checkIfAnyErrors model =
    let
        isValid =
            if model.usernameError == "" && model.cardNumberError == "" && model.cardExpDateError == "" && model.cardCvcError == "" then
                True

            else
                False
    in
    isValid


checkIfAnyEmptyStrings : Model -> Bool
checkIfAnyEmptyStrings model =
    let
        isValid =
            if model.currentUsername /= "" && model.currentCardData /= "" && model.currentExpDateMonth /= "" && model.currentExpDateYear /= "" && model.currentCvc /= "" then
                True

            else
                False
    in
    isValid

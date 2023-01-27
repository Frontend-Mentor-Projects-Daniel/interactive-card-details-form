module Main exposing (Model, Msg, main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (alt, class, for, href, id, maxlength, name, placeholder, src, target, type_, value, width)
import Html.Attributes.Aria exposing (ariaDescribedby, ariaLive)
import Html.Events exposing (onClick, onInput, onSubmit)
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
    , page : Page
    }



--** TYPES


type Page
    = MainForm
    | ThankYouPage



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
      , page = MainForm
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
    | GoBackToEmptyForm


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
                -- { model | currentUsername = "", currentCardData = "", currentExpDateMonth = "", currentExpDateYear = "", currentCvc = "", page = ThankYouPage }
                { model | page = ThankYouPage }

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
            if validateExpDateMonth expDate == True then
                { model | currentExpDateMonth = expDate, cardExpDateError = "" }

            else
                { model | currentExpDateMonth = expDate, cardExpDateError = "Must be between  01 - 12" }

        CurrentExpDateYearValue expDate ->
            if validateExpDateYear expDate == True then
                { model | currentExpDateYear = expDate, cardExpDateError = "" }

            else
                { model | currentExpDateYear = expDate, cardExpDateError = "Must be in the 2 digits long" }

        CurrentCardCvcValue cvc ->
            if validateCvc cvc == True then
                { model | currentCvc = cvc, cardCvcError = "" }

            else
                { model | currentCvc = cvc, cardCvcError = "Must contain 3 numbers" }

        GoBackToEmptyForm ->
            { model | currentUsername = "", currentCardData = "", currentExpDateMonth = "", currentExpDateYear = "", currentCvc = "", page = MainForm }
    , Cmd.none
    )



--** VIEW


view : Model -> Html Msg
view model =
    div [ id "root" ]
        [ header [ class "header" ]
            [ h1 [ class "sr-only" ] [ text "Interactive Card Details Form" ]
            ]

        -- .content-grid
        , main_ [ class "wrapper center" ]
            -- card as in credit card, not a card component
            -- .card-previews
            [ div [ class "card card-image" ]
                [ div [ class "card-front" ]
                    [ img [ class "card-front__bg", src "./images/bg-card-front.png", alt "" ] []
                    , img [ class "card-front__logo", src "./images/card-logo.svg", alt "" ] []
                    , span [ class "card-front__number" ] [ text <| baseTextOrUserInput model.currentCardData "0000 0000 0000 0000" ]
                    , span [ class "card-front__name" ] [ text <| baseTextOrUserInput model.currentUsername "Jane Appleseed" ]
                    , span [ class "card-front__expiry" ]
                        [ span [] [ text <| baseTextOrUserInput model.currentExpDateMonth "00" ]
                        , span [] [ text " / " ]
                        , span [] [ text <| baseTextOrUserInput model.currentExpDateYear "00" ]
                        ]
                    ]
                , div [ class "card-back" ]
                    [ img [ class "card-back__bg", src "./images/bg-card-back.png", alt "" ] []
                    , span [ class "card-back__cvc" ] [ text <| baseTextOrUserInput model.currentCvc "123" ]
                    ]
                ]
            , case model.page of
                MainForm ->
                    viewMainForm model

                ThankYouPage ->
                    viewThankYouPage
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
--& MAIN FORM


viewMainForm : Model -> Html Msg
viewMainForm model =
    div [ class "card card-form" ]
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



--& THANK YOU PAGE


viewThankYouPage : Html Msg
viewThankYouPage =
    div [ class "thank-you-page center" ]
        [ div [ class "image-wrapper" ]
            [ img [ src "./images/icon-complete.svg" ] []
            ]
        , h2 [] [ text "thank you" ]
        , p [] [ text "We’ve added your card details" ]
        , button [ onClick GoBackToEmptyForm ] [ text "Continue" ]
        ]



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


validateExpDateMonth : String -> Bool
validateExpDateMonth expDate =
    Regex.contains regexExpDateMonth expDate


validateExpDateYear : String -> Bool
validateExpDateYear expDate =
    Regex.contains regexExpDateYear expDate


validateCvc : String -> Bool
validateCvc cvc =
    Regex.contains regexCvc cvc



--** HELPER FUNCTIONS


regexCardNumber : Regex.Regex
regexCardNumber =
    Maybe.withDefault Regex.never <|
        Regex.fromString "^[0-9]{4} [0-9]{4} [0-9]{4} [0-9]{4}$"


regexExpDateMonth : Regex.Regex
regexExpDateMonth =
    Maybe.withDefault Regex.never <|
        Regex.fromString "^(0[1-9]|1[0-2])$"


regexExpDateYear : Regex.Regex
regexExpDateYear =
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


baseTextOrUserInput : String -> String -> String
baseTextOrUserInput value defaultString =
    if value == "" then
        defaultString

    else
        value

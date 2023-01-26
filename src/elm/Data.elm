--! THIS FOLDER CONTAINS THINGS I USED FOR MY PREVIOUS METHOD BUT ARE NO LONGER NECESSARY


module Data exposing (..)


type alias LabelProps =
    { for : String, text : String }


type alias LabelWithClassProps =
    { for : String, text : String, class : String }


type alias InputProps =
    { type_ : String
    , id : String
    , name : String
    , placeholder : String
    }


type alias ErrorMessageProps =
    { class : String, id : String, ariaLive : String, text : String }



-- NAME INPUT


nameLabel : LabelProps
nameLabel =
    { for = "name", text = "cardholder name" }


nameInput : InputProps
nameInput =
    { type_ = "text"
    , id = "name"
    , name = "name"
    , placeholder = "e.g. Jane Appleseed"
    }


nameError : ErrorMessageProps
nameError =
    { class = "error error--name", id = "error--name", ariaLive = "polite", text = "" }



-- CARD NUMBER INPUT


numberLabel : LabelProps
numberLabel =
    { for = "number", text = "card number" }


numberInput : InputProps
numberInput =
    { type_ = "text"
    , id = "number"
    , name = "number"
    , placeholder = "e.g. 1234 5678 9123 0000"

    -- , pattern = Just "[0-9]{4}[ -]?[0-9]{4}[ -]?[0-9]{4}[ -]?[0-9]{4}|[0-9]{16}"
    }


numberError : ErrorMessageProps
numberError =
    { class = "error error--number", id = "error--number", ariaLive = "polite", text = "" }



-- EXPIRATION DATE INPUT


expiryLabelMonth : LabelWithClassProps
expiryLabelMonth =
    { for = "month", text = "expiration date, month", class = "sr-only" }


expiryLabelYear : LabelWithClassProps
expiryLabelYear =
    { for = "year", text = "expiration date, year", class = "sr-only" }


expiryInputMonth : InputProps
expiryInputMonth =
    { type_ = "text"
    , id = "month"
    , name = "month"
    , placeholder = "MM"

    -- , pattern = Just "^(0[1-9]|1[0-2])$"
    }


expiryInputYear : InputProps
expiryInputYear =
    { type_ = "text"
    , id = "year"
    , name = "year"
    , placeholder = "YY"

    -- , pattern = Just "^\\d+$"
    }


expiryError : ErrorMessageProps
expiryError =
    { class = "error error--expiry-date", id = "error--expiry-date", ariaLive = "polite", text = "" }


cvcLabel : LabelProps
cvcLabel =
    { for = "cvc", text = "cvc" }


cvcInput : InputProps
cvcInput =
    { type_ = "text"
    , id = "cvc"
    , name = "cvc"
    , placeholder = "123"

    -- , pattern = Just "^\\d+$"
    }


cvcError : ErrorMessageProps
cvcError =
    { class = "error error--cvc", id = "error--cvc", ariaLive = "polite", text = "" }


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

port module StoreList exposing (main)

import Browser
import Html exposing (..)
import Html.Events exposing (onClick)
import Item exposing (Item)
import Maybe exposing (Maybe(..))
import String exposing (fromInt)



-- MODEL


type alias Model =
    List Item


init : flags -> ( Model, Cmd Msg )
init _ =
    ( [ { id = "Hej1"
        , name = "Fin pryl 1"
        , quantity = Nothing
        , stock = 2
        , price = 2.3
        }
      , { id = "Hej2"
        , name = "Fin pryl 2"
        , quantity = Nothing
        , stock = 2
        , price = 2.3
        }
      ]
    , Cmd.none
    )



-- VIEW


itemToHtml : Item -> Html Msg
itemToHtml item =
    div []
        [ text item.name
        , br [] []
        , text ("Stock: " ++ (fromInt item.stock))
        , br [] []
        , button [ onClick (AddToCart item) ] [ text "Add to cart" ]
        ]


view : Model -> Html Msg
view model =
    div []
        (model |> List.map itemToHtml)



-- UPDATE


type Msg
    = AddToCart Item


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddToCart item ->
            ( model, countOutput item )


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


port countOutput : Item -> Cmd msg

port module Cart exposing (main)
 
import Browser
import Html exposing (..)
import Html.Events
import Json.Encode exposing (Value)
import Item exposing (Item, decodeStringToItem)
 
 
type alias Model =
    List Item
 
itemToDiv : Item -> Html Msg
itemToDiv item =
    div [] [(text item.name)]

 
view : Model -> Html Msg
view model =
    div []
        [ (text "Cart")
        , div [] (model |> List.map itemToDiv)
        ]
 
 
type Msg
    = AddToCart Value
 
 
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddToCart value ->
            let
                decoded =  decodeStringToItem value
            in
                case decoded of 
                  Ok item ->
                    ( item :: model , Cmd.none )
                  Err _ -> 
                    (  model , Cmd.none )
 
subscriptions : Model -> Sub Msg
subscriptions _ =
    countInput AddToCart
 
 
port countInput : (Value -> msg) -> Sub msg
 
 
init : () -> ( Model, Cmd Msg )
init _ =
    ( [], Cmd.none )
 
 
main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
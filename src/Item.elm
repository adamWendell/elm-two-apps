module Item exposing (Item, itemDecoder, decodeStringToItem)

import Json.Decode as Decode exposing (Decoder, Error, float, int, nullable, string)
import Json.Decode.Pipeline exposing (required)
import Json.Encode exposing (Value)


type alias Item =
    { id : String
    , name : String
    , quantity : Maybe Int
    , stock : Int
    , price : Float
    }


itemDecoder : Decoder Item
itemDecoder =
    Decode.succeed Item
        |> required "id" string
        |> required "name" string
        |> required "quantity" (nullable int)
        |> required "stock" int
        |> required "price" float

decodeStringToItem : Value -> Result Error Item
decodeStringToItem json =
    Decode.decodeValue
        itemDecoder
        json
defmodule ProductsWeb.Schema.ProductTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Federation.Schema

  object :product do
    key_fields("upc")

    field(:upc, non_null(:string))
    field(:weight, non_null(:integer))
    field(:price, non_null(:integer))
    field(:weight, non_null(:integer))
  end
end

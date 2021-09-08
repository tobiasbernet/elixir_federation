defmodule ProductsWeb.Schema.ProductTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Federation.Notation

  object :product do
    key_fields("upc")

    field(:upc, non_null(:string))
    field(:name, :string)
    field(:price, :integer)
    field(:weight, :integer)
  end
end

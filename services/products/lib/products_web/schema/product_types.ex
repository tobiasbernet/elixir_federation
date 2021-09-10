defmodule ProductsWeb.Schema.ProductTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Federation.Notation

  alias ProductsWeb.Resolvers

  object :product do
    key_fields("upc")

    field(:upc, non_null(:string))
    field(:name, :string)
    field(:price, :integer)
    field(:weight, :integer)

    field(:_resolve_reference, :product) do
      resolve(fn parent, _args, _ -> Resolvers.Products.find(parent, _args, nil) end)
    end
  end
end

defmodule ProductsWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Federation.Schema

  import_types(ProductsWeb.Schema.ProductTypes)

  alias ProductsWeb.Resolvers

  query do
    @desc "Get a top products"
    field :topProducts, list_of(:product) do
      arg(:first, non_null(:integer))
      resolve(&Resolvers.Products.get_top/3)
    end
  end
end

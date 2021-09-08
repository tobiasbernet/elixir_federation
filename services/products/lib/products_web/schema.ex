defmodule ProductsWeb.Schema do
  use Absinthe.Schema
  import_types(ProductsWeb.Schema.ProductTypes)

  alias InventoryWeb.Resolvers

  query do
    @desc "Get a product"
    field :product, :product do
      arg(:upc, non_null(:string))
      resolve(&Resolvers.Products.find/3)
    end

    @desc "Get a top products"
    field :product, list_of(:product) do
      arg(:first, non_null(:integer))
      resolve(&Resolvers.Products.get_top/3)
    end

    field :_service, :service_sdl do
      resolve(&Resolvers.Products.sdl/3)
    end
  end
end

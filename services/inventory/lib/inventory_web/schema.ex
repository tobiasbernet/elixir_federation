defmodule InventoryWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Federation.Schema

  import_types(InventoryWeb.Schema.InventoryTypes)

  alias InventoryWeb.Resolvers

  query do
    @desc "Get current user"
    field :inventory, :product do
      arg(:product, non_null(:string))
      resolve(&Resolvers.Inventory.find/3)
    end
  end
end

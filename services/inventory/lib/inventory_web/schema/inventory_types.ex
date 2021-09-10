defmodule InventoryWeb.Schema.InventoryTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Federation.Notation

  alias InventoryWeb.Resolvers

  object :product do
    key_fields("upc")
    extends()

    field(:upc, non_null(:string), do: external())
    field(:weight, :integer, do: external())
    field(:price, :integer, do: external())
    field(:in_stock, :boolean)

    field(:shipping_estimate, :float) do
      requires_fields("price weight")

      resolve(fn parent, _args, _ -> Resolvers.Inventory.shipping_estimate(parent, _args, nil) end)
    end
  end
end

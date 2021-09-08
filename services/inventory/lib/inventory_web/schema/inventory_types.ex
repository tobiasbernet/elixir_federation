defmodule InventoryWeb.Schema.InventoryTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Federation.Notation

  object :product do
    extends()
    key_fields("upc")

    field(:upc, non_null(:string), do: external())
    field(:weight, :integer, do: external())
    field(:price, :integer, do: external())
    field(:in_stock, :boolean)
    field(:shippingEstimate,  :integer, do: requires_fields("price weight"))
  end
end

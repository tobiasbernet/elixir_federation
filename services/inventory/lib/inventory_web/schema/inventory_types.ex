defmodule InventoryWeb.Schema.InventoryTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Federation.Schema

  object :product do
    key_fields("upc")
    extends()

    field(:upc, non_null(:string), do: external())
    field(:weight, non_null(:integer), do: external())
    field(:price, non_null(:integer), do: external())
    field(:in_stock, :boolean)
  end

  object :service_sdl do
    field(:sdl, :string)
  end
end

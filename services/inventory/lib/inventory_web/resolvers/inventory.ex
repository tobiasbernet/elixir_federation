defmodule InventoryWeb.Resolvers.Inventory do
  defstruct [:upc, :inStock]

  def find(_parent, %{__typename: "Product", upc: upc}, _resolution) do
    {:ok, find_by(%{upc: upc})}
  end

  def find(_parent, arg, _resolution) do
    {:ok, find_by(arg)}
  end

  def shipping_estimate(
        %{"__typename" => "Product", "price" => price, "upc" => _upc, "weight" => weight},
        _args,
        _resolution
      )
      when price < 1000 do
    {:ok, weight * 0.5}
  end

  def shipping_estimate(
        %{"__typename" => "Product", "price" => _price, "upc" => _upc, "weight" => _weight},
        _args,
        _resolution
      ) do
    {:ok, 0}
  end

  defp find_by(%{upc: upc}) do
    inventory()
    |> Enum.find(fn i -> i.upc == upc end)
  end

  defp inventory do
    [
      %__MODULE__{upc: "1", inStock: true},
      %__MODULE__{upc: "2", inStock: false},
      %__MODULE__{upc: "3", inStock: true}
    ]
  end
end

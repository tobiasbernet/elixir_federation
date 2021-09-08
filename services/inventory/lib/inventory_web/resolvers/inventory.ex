defmodule InventoryWeb.Resolvers.Inventory do
  use ExMachina

  def find(_parent, arg, _resolution) do
    {:ok, find_by(arg)}
  end

  defp find_by(%{upc: upc}) do
    inventory()
    |> Enum.find(fn i -> i.upc == upc end)
  end

  defp inventory do
    [
      %{upc: "1", inStock: true},
      %{upc: "2", inStock: false},
      %{upc: "3", inStock: true}
    ]
  end
end

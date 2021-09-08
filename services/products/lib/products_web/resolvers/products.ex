defmodule ProductsWeb.Resolvers.Products do
  use ExMachina

  def find(_parent, arg, _resolution) do
    {:ok, find_by(arg)}
  end

  def get_top(_parent, %{first: n}, _resolution) do
    {:ok, Enum.take(products, n)}
  end

  defp find_by(%{upc: upc}) do
    products()
    |> Enum.find(fn i -> i.upc == upc end)
  end

  defp products do
    [
      %{
        upc: "1",
        name: "Table",
        price: 899,
        weight: 100
      },
      %{
        upc: "2",
        name: "Couch",
        price: 1299,
        weight: 1000
      },
      %{
        upc: "3",
        name: "Chair",
        price: 54,
        weight: 50
      }
    ]
  end
end

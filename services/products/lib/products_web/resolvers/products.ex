defmodule ProductsWeb.Resolvers.Products do

  defstruct [:upc, :name, :price, :weight]

  def find(%{__typename: "Product", upc: upc}, _args, _resolution) do
    {:ok, find_by(%{upc: upc})}
  end

  def find(_parent, arg, _resolution) do
    {:ok, find_by(arg)}
  end

  def get_top(_parent, %{first: n}, _resolution) do
    {:ok, Enum.take(products(), n)}
  end

  defp find_by(%{upc: upc}) do
    products()
    |> Enum.find(fn i -> i.upc == upc end)
  end

  defp products do
    [
      %__MODULE__{
        upc: "1",
        name: "Table",
        price: 899,
        weight: 100
      },
      %__MODULE__{
        upc: "2",
        name: "Couch",
        price: 1299,
        weight: 1000
      },
      %__MODULE__{
        upc: "3",
        name: "Chair",
        price: 54,
        weight: 50
      }
    ]
  end
end

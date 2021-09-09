defmodule ReviewsWeb.Resolvers.Reviews do
  use ExMachina

  def find(_parent, %{id: id}, _resolution) do
    {:ok, filter_by(:authorID, id)}
  end

  def find(%{"__typename" => "User", "id" => id}, _args, _resolution) do
    {:ok, filter_by(:authorID, String.to_integer(id))}
  end

  def reviews(_parent, %{id: id}, _resolution) do
    {:ok, filter_by(:authorID, id)}
  end

  def reviews(_parent, %{}, _resolution) do
    {:ok, reviews()}
  end

  def review(parent, _arg, _resolution) do
    {:ok, parent}
  end

  def number_of_reviews(%{"__typename" => "User", "id" => id}, _args, _resolution) do
    n =
      filter_by(:authorID, String.to_integer(id))
      |> length()

    {:ok, n}
  end

  def username(%{authorID: id}, _args, _resolution) do
    username =
      usernames()
      |> Enum.find(fn u -> u.id == id end)
      |> Map.get(:username)

    {:ok, username}
  end

  def product_reviews(_parent, %{upc: upc}, _resolution) do
    {:ok, filter_by(:upc, upc)}
  end

  defp filter_by(key, value) do
    reviews()
    |> Enum.filter(fn i -> Map.get(i, key) == value end)
  end

  defp reviews do
    [
      %{
        id: 1,
        authorID: 1,
        product: %{upc: "1"},
        body: "Love it!"
      },
      %{
        id: 2,
        authorID: 1,
        product: %{upc: "2"},
        body: "Too expensive."
      },
      %{
        id: 3,
        authorID: 2,
        product: %{upc: "3"},
        body: "Could be better."
      },
      %{
        id: 4,
        authorID: 2,
        product: %{upc: "1"},
        body: "Prefer something else."
      }
    ]
  end

  defp usernames do
    [
      %{id: 1, username: "@ada"},
      %{id: 2, username: "@complete"}
    ]
  end
end

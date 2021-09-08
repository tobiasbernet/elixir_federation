defmodule ReviewsWeb.Resolvers.Reviews do
  use ExMachina

  def find(_parent, %{id: id}, _resolution) do
    {:ok, find_by(:authorId, id)}
  end

  def reviews(_parent, %{id: id}, _resolution) do
    {:ok, find_by(:authorID, id)}
  end

  def number_of_reviews(_parent, %{id: id}, _resolution) do
    n =
      find_by(:authorID, id)
      |> length()

    {:ok, n}
  end

  def username(_parent, %{id: id}, _resolution) do
    username =
      usernames()
      |> Enum.find(fn u -> u.id == id end)
      |> Map.get(:username)

    {:ok, username}
  end

  def product_reviews(_parent, %{upc: upc}, _resolution) do
    {:ok, find_by(:upc, upc)}
  end

  defp find_by(key, value) do
    reviews()
    |> Enum.find(fn i -> Map.get(i, key) == value end)
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

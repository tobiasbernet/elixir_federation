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

  @doc """
  Resolve the sdl file for apollo federation (ApolloGetServiceDefinition)
  """
  def sdl(_, _, _) do
    ProductsWeb.Schema
    |> generate_schema()
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

  def generate_schema(schema) do
    pipeline =
      schema
      |> Absinthe.Pipeline.for_schema(prototype_schema: schema.__absinthe_prototype_schema__())
      |> Absinthe.Pipeline.upto({Absinthe.Phase.Schema.Validation.Result, pass: :final})
      |> Absinthe.Schema.apply_modifiers(schema)

    with {:ok, blueprint, _phases} <-
           Absinthe.Pipeline.run(
             schema.__absinthe_blueprint__(),
             pipeline
           ) do
      sdl =
        blueprint
        |> inspect(pretty: true)
        |> String.replace("\"Represents a schema\"", "")

      {:ok, %{sdl: sdl}}
    else
      _ -> {:error, "Failed to render schema"}
    end
  end
end

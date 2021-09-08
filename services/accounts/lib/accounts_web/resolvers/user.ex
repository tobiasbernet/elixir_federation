defmodule AccountsWeb.Resolvers.User do
  use ExMachina

  def find(_parent, arg, _resolution) do
    {:ok, find_by(arg)}
  end

  @doc """
  Resolve the sdl file for apollo federation (ApolloGetServiceDefinition)
  """
  def sdl(_, _, _) do
    AccountsWeb.Schema
    |> generate_schema()
  end

  defp find_by(%{id: id}) do
    %{
      id: id,
      name: sequence("name"),
      username: sequence(:email, &"email-#{&1}@example.com")
    }
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

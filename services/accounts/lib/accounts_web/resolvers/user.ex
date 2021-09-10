defmodule AccountsWeb.Resolvers.User do
  @doc """
  The return value of the `_resolve_reference` needs to be a struct or `%{__typename: typename}`.

  See: https://github.com/DivvyPayHQ/absinthe_federation/blob/main/lib/absinthe/federation/schema/entity_union.ex#L24
  """
  defstruct [:id, :name, :birthDate, :username]

  def find(_parent, %{__typename: "User", id: id}, _resolution) do
    result =
      users()
      |> Enum.find(fn u -> u.id == id end)
      |> IO.inspect()

    {:ok, result}
  end

  def find(_parent, _arg, _resolution) do
    {:ok, List.first(users())}
  end

  defp users do
    [
      %__MODULE__{
        id: "1",
        name: "Ada Lovelace",
        birthDate: "1815-12-10",
        username: "@ada"
      },
      %__MODULE__{
        id: "2",
        name: "Alan Turing",
        birthDate: "1912-06-23",
        username: "@complete"
      }
    ]
  end
end

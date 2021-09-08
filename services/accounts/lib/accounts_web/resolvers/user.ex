defmodule AccountsWeb.Resolvers.User do
  use ExMachina

  def find(_parent, _arg, _resolution) do
    {:ok, List.first(users())}
  end

  defp users do
    [
      %{
        id: "1",
        name: "Ada Lovelace",
        birthDate: "1815-12-10",
        username: "@ada"
      },
      %{
        id: "2",
        name: "Alan Turing",
        birthDate: "1912-06-23",
        username: "@complete"
      }
    ]
  end
end

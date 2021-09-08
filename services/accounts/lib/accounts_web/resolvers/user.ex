defmodule AccountsWeb.Resolvers.User do
  use ExMachina

  def find(_parent, arg, _resolution) do
    {:ok, find_by(arg)}
  end

  defp find_by(%{id: id}) do
    %{
      id: id,
      name: sequence("name"),
      username: sequence(:email, &"email-#{&1}@example.com")
    }
  end
end

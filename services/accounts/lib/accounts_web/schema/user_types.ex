defmodule AccountsWeb.Schema.UserTypes do
  use Absinthe.Schema.Notation

  object :user do
    field(:id, :id)
    field(:name, :string)
    field(:username, :string)
  end

  object :service_sdl do
    field(:sdl, :string)
  end
end

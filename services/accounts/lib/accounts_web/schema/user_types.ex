defmodule AccountsWeb.Schema.UserTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Federation.Notation

  object :user do
    key_fields("id")

    field(:id, non_null(:id))
    field(:name, :string)
    field(:username, :string)
  end
end

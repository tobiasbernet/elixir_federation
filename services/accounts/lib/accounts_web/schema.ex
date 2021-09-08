defmodule AccountsWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Federation.Schema

  import_types(AccountsWeb.Schema.UserTypes)

  alias AccountsWeb.Resolvers

  query do
    @desc "Get current user"
    field :me, :user do
      arg(:id, non_null(:id))
      resolve(&Resolvers.User.find/3)
    end
  end
end

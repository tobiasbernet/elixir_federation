defmodule AccountsWeb.Schema.UserTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Federation.Notation

  alias AccountsWeb.Resolvers

  object :user do
    key_fields("id")

    field(:id, non_null(:id))
    field(:name, :string)
    field(:username, :string)

    field(:_resolve_reference, :user) do
      # resolve(&Resolvers.User.find/3)
      # raises ->
      # (FunctionClauseError) no function clause matching in Absinthe.Middleware.unshim/2
      #   (absinthe 1.6.5) lib/absinthe/middleware.ex:293: Absinthe.Middleware.unshim([{Absinthe.Middleware.Telemetry, []}, {{Absinthe.Resolution, :call}, &AccountsWeb.Resolvers.User.find/3}], AccountsWeb.Schema)

      # So we need to call the resolver in a anonymous function:
      resolve(fn _, args, _ -> Resolvers.User.find(nil, args, nil) end)
    end
  end
end

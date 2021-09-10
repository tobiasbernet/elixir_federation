# Elixir Federation Demo

This repository is a demo of using [Apollo Federation](https://github.com/apollographql/federation), [Elixir Absinthe](https://hexdocs.pm/absinthe/overview.html) including the [Absinthe Federation](https://hexdocs.pm/absinthe_federation/readme.html) library.

This code is highly experimental. It's is just for fun. The resolvers are not ideal but in this state I just tried to make the queries running.

It's more about learning the federation principles and testing the Elixir lib. So far I found one issue regarding the `:_resolve_reference` field.

```Elixir
# resolve(&Resolvers.User.find/3)
      # raises ->
      # (FunctionClauseError) no function clause matching in Absinthe.Middleware.unshim/2
      #   (absinthe 1.6.5) lib/absinthe/middleware.ex:293: Absinthe.Middleware.unshim([{Absinthe.Middleware.Telemetry, []}, {{Absinthe.Resolution, :call}, &AccountsWeb.Resolvers.User.find/3}], AccountsWeb.Schema)

      # So we need to call the resolver in a anonymous function:
      resolve(fn _, args, _ -> Resolvers.User.find(nil, args, nil) end)
```

## Run the configuration

The project runs in different `tmux` windows. You just have to run the `./startup.sh` script. 

This script lunches 5 tmux windows:
`0:AccountsM 1:Inventory  2:Products  3:Reviews- 4:Apollo Gateway`
ExUnit.start

Mix.Task.run "ecto.create", ~w(-r SportsTeamGo.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r SportsTeamGo.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(SportsTeamGo.Repo)


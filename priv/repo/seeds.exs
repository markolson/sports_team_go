alias SportsTeamGo.Team
alias SportsTeamGo.User
alias SportsTeamGo.Repo

user = User.changeset(%User{}, %{name: "Mark Olson", email: "theothermarkolson@gmail.com"}) |> Repo.insert!
team_1 = Team.changeset(%Team{}, %{name: "Bad News Bears"}) |> Repo.insert!
team_2 = Team.changeset(%Team{}, %{name: "Freezer Burn"}) |> Repo.insert!

User.register_on_team(user, team_1)
User.register_on_team(user, team_2)

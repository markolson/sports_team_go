defmodule SportsTeamGo.Management.TeamRegistrationTest do
  use SportsTeamGo.ModelCase
  alias SportsTeamGo.Management.TeamRegistration
  alias SportsTeamGo.{Team,User,TeamMember}

  setup do
    user = User.changeset(%User{}, %{email: "test@domain.com", name: "mowgli"}) |> Repo.insert!
    team_one = Team.changeset(%Team{}, %{name: "Bad News Bears"}) |> Repo.insert!
    team_two = Team.changeset(%Team{}, %{name: "Freezer Burn"}) |> Repo.insert!

    {:ok, %{ user: user, team_one: team_one, team_two: team_two }}
  end

  test "Users can be added on teams", %{user: user, team_one: team} do
    assert 0 = Enum.count(Repo.all(TeamMember))
    {:ok, _} = TeamRegistration.add_user_to_team(user, team)
    assert 1 = Enum.count(Repo.all(TeamMember))
    %{teams: teams=[team]} = Repo.one(from u in User, preload: [:teams])
    assert 1 = Enum.count(teams)
    assert "Bad News Bears" = team.name
  end

  test "Users can accept spots on teams", %{user: user, team_one: team} do
    {:ok, _} = TeamRegistration.add_user_to_team(user, team)
    assert nil == Repo.get_by(TeamMember, accepted: true)
    {:ok, _} = TeamRegistration.accept_membership(user, team)
    assert nil != Repo.get_by(TeamMember, accepted: true)
  end

end

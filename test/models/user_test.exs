defmodule SportsTeamGo.UserTest do
  use SportsTeamGo.ModelCase

  alias SportsTeamGo.User
  alias SportsTeamGo.Repo
  alias SportsTeamGo.Team
  alias SportsTeamGo.TeamMember

  @valid_attrs %{email: "test@domain.com", name: "mowgli"}
  @invalid_attrs %{}

  setup do
    user = User.changeset(%User{}, @valid_attrs) |> Repo.insert!
    team_one = Team.changeset(%Team{}, %{name: "Bad News Bears"}) |> Repo.insert!
    team_two = Team.changeset(%Team{}, %{name: "Freezer Burn"}) |> Repo.insert!

    {:ok, %{ user: user, team_one: team_one, team_two: team_two }}
  end

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "User has many associated teams", %{user: user, team_one: team_one, team_two: team_two} do
    uno = %{user_id: user.id, team_id: team_one.id, accepted: true}
    dos = %{user_id: user.id, team_id: team_two.id, accepted: true}
    TeamMember.changeset(%TeamMember{}, uno) |> Repo.insert
    TeamMember.changeset(%TeamMember{}, dos) |> Repo.insert

    %{teams: teams} = (from User, preload: [:teams]) |> Repo.get_by(id: user.id)
    assert 2 = Enum.count(teams)
    assert ["Bad News Bears", "Freezer Burn"] == Enum.map(teams, &(&1.name))
  end

  test "Users can be added on teams", %{user: user, team_one: team} do
    assert 0 = Enum.count(Repo.all(TeamMember))
    {:ok, _} = User.register_on_team(user, team)
    assert 1 = Enum.count(Repo.all(TeamMember))
    %{teams: teams=[team]} = Repo.one(from u in User, preload: [:teams])
    assert 1 = Enum.count(teams)
    assert "Bad News Bears" = team.name
  end

end

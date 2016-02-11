defmodule SportsTeamGo.TeamMemberTest do
  use SportsTeamGo.ModelCase

  alias SportsTeamGo.TeamMember

  @valid_attrs %{accepted: true, team_id: "123", user_id: "456"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = TeamMember.changeset(%TeamMember{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = TeamMember.changeset(%TeamMember{}, @invalid_attrs)
    assert changeset.model.accepted == nil
  end
end

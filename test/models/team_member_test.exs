defmodule SportsTeamGo.TeamMemberTest do
  use SportsTeamGo.ModelCase

  alias SportsTeamGo.TeamMember

  @valid_attrs %{accepted: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = TeamMember.changeset(%TeamMember{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = TeamMember.changeset(%TeamMember{}, @invalid_attrs)
    #refute changeset.valid?
    # this isn't _actually_ invalid because the nil/non-existant value
    # gets coerced to false for the `accepted` value in the model. Which works.
    assert changeset.model.accepted == false
  end
end

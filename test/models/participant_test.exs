defmodule SportsTeamGo.ParticipantTest do
  use SportsTeamGo.ModelCase

  alias SportsTeamGo.Participant

  @valid_attrs %{team_id: "123", game_id: "456"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Participant.changeset(%Participant{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Participant.changeset(%Participant{}, @invalid_attrs)
    refute changeset.valid?
  end
end

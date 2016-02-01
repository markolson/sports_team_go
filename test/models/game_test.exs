defmodule SportsTeamGo.GameTest do
  use SportsTeamGo.ModelCase

  alias SportsTeamGo.Game

  @valid_attrs %{end: "2010-04-17 14:00:00", start: "2010-04-17 14:00:00"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Game.changeset(%Game{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Game.changeset(%Game{}, @invalid_attrs)
    refute changeset.valid?
  end
end

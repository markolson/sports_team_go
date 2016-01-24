defmodule SportsTeamGo.UserTest do
  use SportsTeamGo.ModelCase

  alias SportsTeamGo.User

  @valid_attrs %{email: "test@domain.com", name: "mowgli"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end

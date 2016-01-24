defmodule SportsTeamGo.AuthenticateTest do
  use SportsTeamGo.ModelCase
  alias SportsTeamGo.Authenticate
  alias SportsTeamGo.Repo
  alias SportsTeamGo.User
  alias SportsTeamGo.Authorization
  import Ecto.Query

  defp count_for(table), do: from(w in table) |> select([u], count(u.id)) |> Repo.all |> hd

  setup do
    auth_info = %Ueberauth.Auth{
      uid: "mowgli@jung.le",
      info: %Ueberauth.Auth.Info{
        name: "Mowgli",
        email: "mowgli@jung.le"
      }
    }

    good_ident_auth_info = %{auth_info |
      provider: :identity,
      credentials: %Ueberauth.Auth.Credentials{
        other: %{ password: "Swing", password_confirmation: "Swing" }
      }
    }

    {:ok, %{
      good_ident: good_ident_auth_info
    }}
  end



  test "creates a User/Auth if none exist", %{good_ident: g} do
    assert 0 == count_for(User), "User table is not blank"
    assert 0 == count_for(SportsTeamGo.Authorization), "Auth table is not blank"

    Authenticate.fetch(g, Repo)

    assert 1 == count_for(User), "User table is blank"
    assert 1 == count_for(SportsTeamGo.Authorization), "Auth table is blank"

    user = User |> limit(1) |> Repo.all |> hd
    assert user.email == "mowgli@jung.le"
    assert user.name == "Mowgli"
  end

  test "creates an Auth if a user exists", %{good_ident: g} do
    {:ok, user} = User.changeset(%User{}, %{name: "Mowgli", email: "mowgli@jung.le"}) |> Repo.insert

    assert 1 == count_for(User), "User table is blank"
    assert 0 == count_for(Authorization), "Auth table is not blank"

    auth = Authenticate.fetch(g, Repo)

    assert 1 == count_for(User), "User table has the wrong number of entries"
    assert 1 == count_for(SportsTeamGo.Authorization), "Auth table is blank"

    assert user.id == auth.user_id
  end
end

defmodule SportsTeamGo.AuthenticateTest do
  use SportsTeamGo.ModelCase
  alias SportsTeamGo.Authenticate
  alias SportsTeamGo.Repo

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



  test "auth test", %{good_ident: g} do
    Authenticate.fetch(g, Repo)
  end

  test "creates an authentication upon request", %{good_ident: g} do
    Authenticate.create_from_auth(g, Repo)
  end
end

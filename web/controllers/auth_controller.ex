defmodule SportsTeamGo.AuthController do
  use SportsTeamGo.Web, :controller
  plug Ueberauth

  alias SportsTeamGo.Authenticate


  def login(conn, _params) do
    render conn, "login.html"
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    case Authenticate.fetch(auth, SportsTeamGo.Repo) do
      {:error, :must_register_for_ident} -> text conn, "you must register"
      result -> text conn, result
    end
  end
end

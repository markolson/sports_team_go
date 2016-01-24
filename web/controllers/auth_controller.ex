defmodule SportsTeamGo.AuthController do
  use SportsTeamGo.Web, :controller
  plug Ueberauth

  alias SportsTeamGo.Authenticate


  def login(conn, _params) do
    render conn, "login.html"
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    result = Authenticate.fetch(auth, SportsTeamGo.Repo)
    text conn, result
  end
end

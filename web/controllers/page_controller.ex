defmodule SportsTeamGo.PageController do
  use SportsTeamGo.Web, :controller
  use Guardian.Phoenix.Controller

  def index(conn, _params, user, _claims) do
    if Guardian.Plug.current_token(conn) do
      teams = SportsTeamGo.User.accepted_teams(user)
      render conn, "index.html", current_user: user, teams: teams
    else
      redirect(conn, to: auth_path(conn, :login, "identity"))
    end
  end
end

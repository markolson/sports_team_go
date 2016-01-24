defmodule SportsTeamGo.PageController do
  use SportsTeamGo.Web, :controller
  use Guardian.Phoenix.Controller

  def index(conn, params, user, claims) do
    if Guardian.Plug.current_token(conn) do
      render conn, "index.html", current_user: user
    else
      redirect(conn, to: auth_path(conn, :login, "identity"))
    end
  end
end

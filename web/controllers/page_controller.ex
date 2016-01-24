defmodule SportsTeamGo.PageController do
  use SportsTeamGo.Web, :controller

  def index(conn, _params) do
    if Plug.Conn.get_session(conn, :current_user)[:name] do
      render conn, "index.html"
    else
      render conn, "index.html"
    end
  end
end

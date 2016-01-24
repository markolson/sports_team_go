defmodule SportsTeamGo.UserController do
  use SportsTeamGo.Web, :controller

  def new(conn, params) do
    render conn, "new.html"
  end
end

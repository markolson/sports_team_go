defmodule SportsTeamGo.PageControllerTest do
  use SportsTeamGo.ConnCase

  test "GET /", %{conn: conn} do
    get conn, "/"

  end
end

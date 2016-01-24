defmodule SportsTeamGo.PageControllerTest do
  use SportsTeamGo.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"

  end
end

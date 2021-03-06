defmodule SportsTeamGo.AuthController do
  use SportsTeamGo.Web, :controller
  plug Ueberauth

  alias SportsTeamGo.Authenticate


  def login(conn, _params) do
    render conn, "login.html"
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case Authenticate.fetch(auth, SportsTeamGo.Repo) do
      # information leak, but, whatever. easy to treat like a normal
      # failure later.
      {:error, :must_register_for_ident} ->
        conn
        |> put_flash(:error, "No User Found")
        |> redirect(to: user_path(conn, :new))
      {:error, msg} ->
        conn
        |> put_flash(:error, msg)
        |> render("login.html")
      {:ok, user} ->
        conn
        |> Guardian.Plug.sign_in(user)
        |> redirect(to: page_path(conn, :index))
    end
  end

  def logout(conn, _params) do
    conn
    |> put_flash(:info, "Logged Out")
    |> Guardian.Plug.sign_out
    |> redirect(to: page_path(conn, :index))
  end
end

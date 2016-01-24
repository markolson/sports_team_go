defmodule SportsTeamGo.AuthController do
  use SportsTeamGo.Web, :controller
  plug Ueberauth

  alias SportsTeamGo.Authenticate


  def login(conn, _params) do
    render conn, "login.html"
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
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
        |> render "login.html"
      {:ok, user} ->
        user_dict = %{id: user.id, name: user.name}
        conn
        |> put_session(:current_user, user_dict)
        |> redirect(to: page_path(conn, :index))
    end
  end

  def logout(conn, params) do
    conn
    |> put_flash(:info, "Logged Out")
    |> delete_session(:current_user)
    |> redirect(to: page_path(conn, :index))
  end
end

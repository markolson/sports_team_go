defmodule SportsTeamGo.Authenticate do
  alias SportsTeamGo.User
  alias SportsTeamGo.Authorization
  alias Ueberauth.Auth

  def fetch(auth, repo) do
    case find_and_validate(auth, repo) do
      :not_found ->
        t = create_from_auth(auth, repo)
        IO.inspect t
      _ -> true
    end
  end

  defp find_and_validate(%Auth{provider: :identity}=auth, repo) do
    case repo.get_by(Authorization, uid: auth.uid, provider: "identity") do
      nil -> :not_found
      authorization ->
        IO.inspect auth.credentials.other.password
    end
  end

  def create_from_auth(%Auth{provider: :identity}=auth, repo) do
    user = user_from_auth(auth, repo)
    pass = Comeonin.Bcrypt.hashpwsalt(auth.credentials.other.password)
    authorization = Ecto.Model.build(user, :authorizations)
    result = Authorization.changeset(authorization,
      %{ provider: "identity", uid: auth.info.email, token: pass }
    ) |> repo.insert
    case result do
      {:ok, auth} -> auth
    end
  end

  # while dumb as heck until email validation is done
  # for ident, we need to create a user record to hang
  # the authorizations off of.
  # TODO: verified=false on ident
  def user_from_auth(auth, repo) do
    case repo.get_by(User, email: auth.info.email) do
      nil -> create_user(auth.info, repo)
      user -> user
    end
  end

  defp create_user(%{name: name, email: email}=auth, repo) do
    result = User.changeset(%User{}, %{name: name, email: email})
            |> repo.insert
    case result do
      {:ok, user} -> user
    end
  end
end

defmodule SportsTeamGo.Authenticate do
  alias SportsTeamGo.User
  alias SportsTeamGo.Authorization
  alias Ueberauth.Auth

  def fetch(auth, repo) do
    # get a user and try to validate it
    user = user_from_auth(auth, repo)
    case find_and_validate(auth, user, repo) do
      # if we hit an error where we can't register a User, say so
      :must_register -> {:error, :must_register_for_ident}
      # if we can't find the user using auth info, create one
      # along with the Authorization
      :not_found -> create_from_auth(auth, repo)
      # pass through anything else
      {:error, msg} -> {:error, msg}
      authorization -> {:ok, repo.one(Ecto.Model.assoc(authorization, :user))}
    end
  end

  defp find_and_validate(%Auth{provider: :identity}, nil, _), do: :must_register
  defp find_and_validate(%Auth{provider: :identity}=auth, user, repo) do
    case repo.get_by(Authorization, uid: auth.uid, provider: "identity") do
      nil -> :not_found
      authorization ->
        if Comeonin.Bcrypt.checkpw(auth.credentials.other.password, authorization.token) do
          authorization
        else
          {:error, :password_mismatch}
        end
    end
  end

  # Create an Identity Authoriztion for a User
  defp create_from_auth(%Auth{provider: :identity}=auth, repo) do
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
  defp user_from_auth(auth, repo) do
    # find the User by email, which is unique
    case repo.get_by(User, email: auth.info.email) do
      # if there isn't one, create it.
      nil -> create_user(auth.info, repo)
      user -> user
    end
  end

  # build and insert the User
  defp create_user(%{name: name, email: email}=auth, repo) do
    result = User.changeset(%User{}, %{name: name, email: email})
            |> repo.insert
    case result do
      {:ok, user} -> user
      {:error, _} -> nil
    end
  end
end

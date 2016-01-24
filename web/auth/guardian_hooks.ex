defmodule SportsTeamGo.GuardianHooks do
  use Guardian.Hooks

  # lol guardian has a key named 'hooks' but only allows one module
  # lol lol lol
  def after_sign_in(conn, location) do
    GuardianDb.after_sign_in(conn, location)
    IO.inspect conn
    IO.inspect location
    user = Guardian.Plug.current_resource(conn, location)
    IO.puts("SIGNED INTO LOCATION WITH: #{user.email}")
    conn
  end

  def after_encode_and_sign(resource, type, claims, jwt) do
    GuardianDb.after_encode_and_sign(resource, type, claims, jwt)
  end

  def on_verify(claims, jwt) do
    GuardianDb.on_verify(claims, jwt)
  end

  def on_revoke(claims, jwt) do
    GuardianDb.on_revoke(claims, jwt)
  end
end

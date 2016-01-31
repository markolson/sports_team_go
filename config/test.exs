use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sports_team_go, SportsTeamGo.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :sports_team_go, SportsTeamGo.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "sports_team_go_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :comeonin, :bcrypt_log_rounds, 4
config :comeonin, :pbkdf2_rounds, 1

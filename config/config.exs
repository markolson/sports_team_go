# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :sports_team_go, SportsTeamGo.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "PoggJCT7tWorrGXhd5RoajwzTTSBD+aWysoGpwzWZZX88hBJxwsuzn30VPMVIPNB",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: SportsTeamGo.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true

config :ueberauth, Ueberauth,
  providers: [
    identity: {Ueberauth.Strategy.Identity, [scrub_params: false, callback_methods: ["POST"]]}
  ]

config :guardian, Guardian,
  issuer: "SportsTeamGo.#{Mix.env}",
  ttl: {30, :days},
  verify_issuer: true,
  serializer: SportsTeamGo.GuardianSerializer,
  secret_key: to_string(Mix.env),
  hooks: SportsTeamGo.GuardianHooks

config :guardian_db, GuardianDb,
       repo: SportsTeamGo.Repo

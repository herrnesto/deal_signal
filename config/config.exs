# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :deal_signal,
  ecto_repos: [DealSignal.Repo]

# Configures the endpoint
config :deal_signal, DealSignalWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "GkPGAUPfI+PdvRmdtlGBo2Zv+MZbbWO7JhEfhxKK/XKfN+RAtBuS0MU45eSpAb4f",
  render_errors: [view: DealSignalWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: DealSignal.PubSub,
  live_view: [signing_salt: "dgcMwTEQ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

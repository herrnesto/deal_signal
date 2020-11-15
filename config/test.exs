use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
test_partition = System.get_env("MIX_TEST_PARTITION")

config :deal_signal, DealSignal.Repo,
  url: "postgres://postgres:postgress@0.0.0.0:5440/dealsignal_#{test_partition})",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :deal_signal, DealSignalWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

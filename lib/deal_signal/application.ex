defmodule DealSignal.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      DealSignal.Repo,
      # Start the Telemetry supervisor
      DealSignalWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: DealSignal.PubSub},
      # Start the Endpoint (http/https)
      DealSignalWeb.Endpoint,
      # Start a worker by calling: DealSignal.Worker.start_link(arg)
      DealSignal.Scheduler
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DealSignal.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DealSignalWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

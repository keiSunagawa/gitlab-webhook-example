defmodule RequestLogging.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # initialize Http client
    HTTPoison.start

    children = [
      # Start the Ecto repository
      # RequestLogging.Repo,
      # Start the Telemetry supervisor
      RequestLoggingWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: RequestLogging.PubSub},
      # Start the Endpoint (http/https)
      RequestLoggingWeb.Endpoint,
      # Start a worker by calling: RequestLogging.Worker.start_link(arg)
      # {RequestLogging.Worker, arg},
      External.GraphqlClient
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RequestLogging.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    RequestLoggingWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

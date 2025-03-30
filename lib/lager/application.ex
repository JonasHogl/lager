defmodule Lager.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LagerWeb.Telemetry,
      Lager.Repo,
      {DNSCluster, query: Application.get_env(:lager, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Lager.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Lager.Finch},
      # Start a worker by calling: Lager.Worker.start_link(arg)
      # {Lager.Worker, arg},
      # Start to serve requests, typically the last entry
      LagerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Lager.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LagerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

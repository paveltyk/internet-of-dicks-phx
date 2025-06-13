defmodule Dicks.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DicksWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:dicks_phx, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Dicks.PubSub},
      # Start a worker by calling: Dicks.Worker.start_link(arg)
      # {Dicks.Worker, arg},
      # Start to serve requests, typically the last entry
      DicksWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Dicks.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DicksWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

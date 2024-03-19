defmodule LiveBlog.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LiveBlogWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:live_blog, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LiveBlog.PubSub},
      {LiveBlog.Feed, []},
      {LiveBlog.CommentFeed, []},
      # Start a worker by calling: LiveBlog.Worker.start_link(arg)
      # {LiveBlog.Worker, arg},
      # Start to serve requests, typically the last entry
      LiveBlogWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveBlog.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveBlogWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

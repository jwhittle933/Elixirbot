defmodule Elixirbot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  use Application

  def start(_type, _args) do

    children = [
      Plug.Cowboy.child_spec(scheme: :http, plug: Elixirbot.Router, options: [port: 4000])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Elixirbot.Supervisor]
    Supervisor.start_link(children, opts)
    # Slack.Bot.start_link(Elixirbot.Slack, [], @token)
  end
end

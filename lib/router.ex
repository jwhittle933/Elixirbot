defmodule Elixirbot.Router do
  use Plug.Router

  alias Elixirbot.Controller
  alias Elixirbot.Slack
  alias Elixirbot.AssignRequestPlug

  if Mix.env == :dev do
    use Plug.Debugger, otp_app: :elixirbot
    use Plug.ErrorHandler
  end

  plug Plug.Logger, log: :debug
  plug :match
  plug Plug.Parsers, parsers: [:json, :urlencoded], json_decoder: Poison
  plug AssignRequestPlug
  plug :dispatch

  get "/healthcheck" do
    send_resp(conn, 200, "All good.")
  end

  post "/helix" do
    conn
    |> Slack.respond
    |> Controller.respond
  end

  match _ do
    send_resp(conn, 404, "not found")
  end

  defp handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    send_resp(conn, conn.status, "Something went wrong.")
  end
end

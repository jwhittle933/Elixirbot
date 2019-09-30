defmodule Elixirbot.Router do
  use Plug.Router
  use Plug.Debugger, otp_app: :elixirbot

  alias Elixirbot.Controller
  alias Elixirbot.AddExecPlug

  if Mix.env == :dev do
    use Plug.Debugger
  end

  plug Plug.Logger, log: :debug
  plug :match
  plug Plug.Parsers, parsers: [:json, :urlencoded], json_decoder: Poison
  plug AddExecPlug
  plug :dispatch

  post "/webhook" do
    conn
    |> Controller.post_to_slack
    |> Controller.run
  end

  match _ do
    send_resp(conn, 404, "not found")
  end

end

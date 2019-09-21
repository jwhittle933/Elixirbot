defmodule Elixirbot.Router do
  use Plug.Router
  use Plug.Debugger, otp_app: :elixirbot

  @controller Elixirbot.Controller

  plug Plug.Logger
  plug Plug.Parsers, parsers: [:json, :urlencoded], json_decoder: Poison
  plug :match
  plug :dispatch

  post "/webhook" do
    conn
    |> Controller.parse_template
    |> send_resp(200, "Oh yeah")
  end


  match _ do
    send_resp(conn, 404, "not found")
  end

end

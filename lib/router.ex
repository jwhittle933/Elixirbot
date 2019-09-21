defmodule Elixirbot.Router do
  use Plug.Router
  use Plug.Debugger, otp_app: :elixirbot

  plug Plug.Logger
  plug Plug.Parsers, parsers: [:json, :urlencoded], json_decoder: Poison
  plug :match
  plug :dispatch

  post "/webhook" do
    send_resp(conn, 200, "Oh yeah")
  end


  match _ do
    send_resp(conn, 404, "not found")
  end

end

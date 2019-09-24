defmodule Elixirbot.Router do
  use Plug.Router
  use Plug.Debugger, otp_app: :elixirbot

  alias Elixirbot.Controller
  alias Elixirbot.TemplatePlug

  plug Plug.Logger
  plug Plug.Parsers, parsers: [:json], json_decoder: Poison
  plug TemplatePlug
  plug :match
  plug :dispatch

  post "/webhook" do
    conn |> Controller.parse_template
  end


  match _ do
    send_resp(conn, 404, "not found")
  end

end

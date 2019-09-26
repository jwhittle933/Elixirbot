defmodule Elixirbot.Controller do
  @moduledoc """
  Controller for parsing .eex
  """
  import Plug.Conn, only: [send_resp: 3]
  alias Elixirbot.BotCode

  @webhook Application.get_env(:elixirbot, :slack_webhook_url)

  def post_to_slack(msg) do
    HTTPoison.post(@webhook, msg)
  end

  def run(conn) do
    conn |> send_resp(200, BotCode.run(conn))
  end
end

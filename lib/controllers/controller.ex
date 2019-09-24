defmodule Elixirbot.Controller do
  @moduledoc """
  Controller for parsing .eex
  """
  import Plug.Conn, only: [send_resp: 3]
  alias Elixirbot.TemplateParser
  alias Elixirbot.BotCode

  @webhook Application.get_env(:elixirbot, :slack_webhook_url)

  def interop(str), do: "defmodule BotCode do\ndef run do\n#{str}\nend\nend"

  # def compile_code(%Plug.Conn{assigns: %{exec: exec}} = conn) do
  #   exec
  #   |> interop
  #   |> Code.compile_string(".log")

  #   conn
  # end

  def post_to_slack(msg) do
    HTTPoison.post(@webhook, msg)
  end

  def parse_template(conn) do
    conn
    |> send_resp(200, BotCode.run(conn))
  end
end

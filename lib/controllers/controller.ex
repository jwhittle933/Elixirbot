defmodule Elixirbot.Controller do
  @moduledoc """
  Controller for parsing .eex
  """
  import Plug.Conn, only: [send_resp: 3]
  alias Elixirbot.BotCode
  alias Elixirbot.Response

  @webhook Application.get_env(:elixirbot, :webhook)

  def post_to_slack(%Plug.Conn{params: params} = conn) do
    {:ok, msg} =
      Response.new(params)
      |> Response.evaluate(BotCode.run(conn))
      |> Poison.encode()

    {_code, _reason} = HTTPoison.post(@webhook, msg)
    conn
  end

  def run(conn) do
    conn |> send_resp(200, BotCode.run(conn))
  end
end

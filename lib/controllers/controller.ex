defmodule Elixirbot.Controller do
  @moduledoc """
  Controller for parsing .eex
  """
  import Plug.Conn, only: [send_resp: 3]
  alias Elixirbot.BotCode
  alias Elixirbot.Response

  @webhook Application.get_env(:elixirbot, :webhook)

  def post_to_slack(%Plug.Conn{params: params, assigns: assigns} = conn) do
    IO.inspect assigns
    {:ok, msg} =
      Response.new(params)
      |> Response.expand(BotCode.run(assigns[:request], "ephemeral"))
      |> Poison.encode()

    {_code, _reason} = HTTPoison.post(@webhook, msg)
    conn
  end

  def respond(%Plug.Conn{assigns: assigns} = conn) do
    conn |> send_resp(200, BotCode.run(assigns[:request]))
  end
end

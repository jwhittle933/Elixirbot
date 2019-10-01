defmodule Elixirbot.Controller do
  @moduledoc """
  Controller for parsing .eex
  """
  import Plug.Conn, only: [send_resp: 3]
  alias Elixirbot.BotCode

  def respond(%Plug.Conn{assigns: assigns} = conn) do
    conn |> send_resp(200, BotCode.run(assigns[:request]))
  end
end

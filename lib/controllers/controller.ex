defmodule Elixirbot.Controller do
  @moduledoc """
  Controller for parsing .eex
  """
  import Plug.Conn, only: [send_resp: 3]

  def respond(%Plug.Conn{assigns: assigns} = conn) do
    conn
    |> send_resp(200, assigns[:eval])
  end

  def respond(conn), do: conn |> send_resp(200, "Error processing code.")
end

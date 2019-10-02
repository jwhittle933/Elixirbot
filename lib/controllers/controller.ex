defmodule Elixirbot.Controller do
  @moduledoc """
  Controller for parsing .eex
  """
  import Plug.Conn, only: [send_resp: 3]

  def respond(%Plug.Conn{assigns: assigns} = conn), do: send_resp(conn, 200, assigns[:resp])

  def respond(conn), do: conn |> send_resp(200, "Error processing code.")
end

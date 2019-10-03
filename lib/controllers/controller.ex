defmodule Elixirbot.Controller do
  @moduledoc """
  Controller for parsing .eex
  """
  import Plug.Conn

  def respond(%Plug.Conn{assigns: assigns} = conn) do
    conn
    |> put_resp_header("Content-type", "application/json")
    |> put_resp_header("Accept", "application/json")
    |> send_resp(200, assigns[:resp])
  end

  def respond(conn), do: conn |> send_resp(200, "Error processing code.")
end

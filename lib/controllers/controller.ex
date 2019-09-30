defmodule Elixirbot.Controller do
  @moduledoc """
  Controller for parsing .eex
  """
  import Plug.Conn, only: [send_resp: 3]
  alias Elixirbot.BotCode
  alias Elixirbot.Response

  @webhook Application.get_env(:elixirbot, :webhook)

  def post_to_channel(%Plug.Conn{assigns: assigns} = conn) do
    IO.inspect assigns
    {:ok, msg} =
      Response.new(%{text: BotCode.run(assigns[:request]), response_type: "ephemeral"})
      |> Poison.encode()

    {_code, _reason} = HTTPoison.post(get_webhook(assigns[:request]), msg)
    conn
  end

  # def post_to_channel(conn), do: conn

  def respond(%Plug.Conn{assigns: assigns} = conn) do
    conn |> send_resp(200, BotCode.run(assigns[:request]))
  end


  defp get_webhook(request) do
    case Map.get(request, :response_url) do
      nil -> @webhook
      _ -> request.response_url
    end
  end
end

defmodule Elixirbot.Slack do
  @moduledoc """
  Slack responses
  """
  alias Elixirbot.BotCode
  alias Elixirbot.Response

  @webhook Application.get_env(:elixirbot, :webhook)

  def respond(%Plug.Conn{assigns: assigns} = conn) do
    request = assigns[:request]
    eval = BotCode.run(request)

    %{text: eval, response_type: "in_channel"}
    |> Response.new
    |> Poison.encode
    |> send_response(request, conn)
  end

  def respond(conn), do: conn

  defp send_response({:ok, msg}, request, conn) do
    {_code, _reason} = HTTPoison.post(get_webhook(request), msg)

    Plug.Conn.assign(conn, :resp, msg)
  end

  defp send_response({:error, e}, request, conn) do
    {_code, _reason} = HTTPoison.post(get_webhook(request), "Encoding error")

    Plug.Conn.assign(conn, :resp, e.message)
  end

  defp get_webhook(request) do
    case Map.get(request, :response_url) do
      nil -> @webhook
      _ -> request.response_url
    end
  end
end

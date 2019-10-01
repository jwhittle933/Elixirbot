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

    %{text: eval, response_type: "ephemeral"}
    |> Response.new
    |> Poison.encode
    |> send_response(request)

    conn
    |> Plug.Conn.assign(:eval, eval)
  end

  def respond(conn), do: conn

  defp send_response({:ok, msg}, request) do
    {code, reason} = HTTPoison.post(get_webhook(request), msg)
    IO.inspect code, label: "\n\nCode"
    IO.inspect reason, label: "\n\nReason"
  end

  defp send_response({:error, _}, request) do
    {code, reason} = HTTPoison.post(get_webhook(request), "Encoding error")
    IO.inspect code, label: "\n\nCode"
    IO.inspect reason, label: "\n\nReason"
  end

  defp get_webhook(request) do
    case Map.get(request, :response_url) do
      nil -> @webhook
      _ -> request.response_url
    end
  end
end

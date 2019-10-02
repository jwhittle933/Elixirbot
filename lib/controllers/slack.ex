defmodule Elixirbot.Slack do
  @moduledoc """
  Slack responses
  """
  alias Elixirbot.BotCode

  @webhook Application.get_env(:elixirbot, :webhook)

  def respond(%Plug.Conn{assigns: assigns} = conn) do
    request = assigns[:request]
    eval = BotCode.run(request)

    %{"text" => "`#{request.text}`", "response_type" => "in_channel", "attachments" => [%{"text" => eval}]}
    |> Jason.encode!
    |> send_response(request, conn)
  end

  def respond(conn), do: conn

  defp send_response(response, request, conn) do
    {_code, _reason} = HTTPoison.post(get_webhook(request), response, [{"Content-type", "application/json"}])

    Plug.Conn.assign(conn, :resp, response)
  end

  defp get_webhook(request) do
    case Map.get(request, :response_url) do
      nil -> @webhook
      _ -> request.response_url
    end
  end
end

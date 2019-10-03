defmodule Elixirbot.Slack do
  @moduledoc """
  Slack responses
  """
  alias Elixirbot.BotCode

  def respond(%Plug.Conn{assigns: assigns} = conn) do
    request = assigns[:request]
    eval = BotCode.run(request)

    %{"text" => "`#{request.text}`", "response_type" => "in_channel", "attachments" => [%{"text" => eval}]}
    |> Jason.encode!
    |> assign_response(conn)
  end

  def respond(conn), do: conn

  defp assign_response(response, conn) do
    Plug.Conn.assign(conn, :resp, response)
  end
end

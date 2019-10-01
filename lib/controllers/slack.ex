defmodule Elixirbot.Slack do
  @moduledoc """
  Slack responses
  """
  alias Elixirbot.BotCode
  alias Elixirbot.Response

  @webhook Application.get_env(:elixirbot, :webhook)

  def respond(%Plug.Conn{assigns: assigns} = conn) do
    {:ok, msg} =
      %{text: BotCode.run(assigns[:request]), response_type: "ephemeral"}
      |> Response.new()
      |> Poison.encode()

    {code, reason} = HTTPoison.post(get_webhook(assigns[:request]), msg)
    IO.inspect code, label: "\n\nCode"
    IO.inspect reason, label: "\n\nReason"
    conn
  end

  def respond(conn), do: conn

  defp get_webhook(request) do
    case Map.get(request, :response_url) do
      nil -> @webhook
      _ -> request.response_url
    end
  end
end

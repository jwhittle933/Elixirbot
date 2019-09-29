defmodule Elixirbot.Slack do
  use Slack

  def handle_message(message = %{type: "message"}, slack, state) do
    IO.inspect message
    send_message("Hello from Elixirbot", message.channel, slack)
    {:ok, state}
  end

  def handle_message(_, _, state) do
    {:ok, state}
  end
end

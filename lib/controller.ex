defmodule Elixirbot.Controller do
  @moduledoc """
  Controller for parsing .eex
  """

  @webhook Application.get_env(:elixirbot, :slack_webhook_url)

  def parse_template(conn) do
    conn
  end
end

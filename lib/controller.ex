defmodule Elixirbot.Controller do
  @moduledoc """
  Controller for parsing .eex
  """
  @webhook Application.get_env(:elixirbot, :slack_webhook_url)

  require EEx
  EEx.function_from_file(:def, :exec, "lib/template.eex", [:exec])

  def run do
    IO.puts exec("Test")
  end

  def post_to_slack(msg) do
    HTTPoison.post(@webhook, msg)
  end

  def parse_template(conn) do
    IO.inspect conn
    conn
  end
end

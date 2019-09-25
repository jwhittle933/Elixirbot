defmodule Elixirbot.BotCode do
  @moduledoc """
  Module for code injection
  """
  alias Elixirbot.Renderer

  def run(%Plug.Conn{assigns: %{exec: exec}}) do
    exec
    |> eval_code
    |> Renderer.render_template
  end

  def eval_code(exec) do
    try do
      {result, _} = Code.eval_string(exec)
      result
    rescue
      e in ArgumentError -> e
    end
  end
end

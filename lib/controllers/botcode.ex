defmodule Elixirbot.BotCode do
  @moduledoc """
  Module for code injection
  """
  def run(%Plug.Conn{assigns: %{exec: exec}}) do
    exec
    |> eval_code
    |> render_template
  end

  def eval_code(exec) do
    {result, _} = Code.eval_string(exec)
    result
  end

  def render_template(result) when is_binary(result) or is_number(result) do
    EEx.eval_file("lib/templates/string_or_number.eex", result: result)
  end

  def render_template(result) when is_list(result) do
    EEx.eval_file("lib/templates/list.eex", result: result)
  end

  def render_template(result) when is_map(result) do
    EEx.eval_file("lib/templates/map.eex", result: result)
  end

  def render_template(result) when is_tuple(result) do
    EEx.eval_file("lib/templates/tuple.eex", result: result)
  end
end

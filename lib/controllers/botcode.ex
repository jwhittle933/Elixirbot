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
    try do
      {result, _} = Code.eval_string(exec)
      result
    rescue
      e in ArgumentError -> e
    end
  end

  def render_template(%ArgumentError{message: message}) do
    EEx.eval_file("lib/templates/error.eex", result: message)
  end

  def render_template(result) when is_binary(result) or is_number(result) or is_boolean(result) do
    EEx.eval_file("lib/templates/string_or_number.eex", result: result)
  end

  def render_template(result) when is_atom(result) do
    EEx.eval_file("lib/templates/string_or_number.eex", result: ":" <> Atom.to_string(result))
  end

  def render_template(result) when is_list(result) do
    EEx.eval_file("lib/templates/list.eex", result: result)
  end

  def render_template(result) when is_map(result) do
    EEx.eval_file("lib/templates/map.eex", result: result)
  end

  def render_template(result) when is_tuple(result) do
    r = Enum.map_join(Tuple.to_list(result), ", ", fn val ->
      case is_atom(val) do
        true -> ":" <> Atom.to_string(val)
        false -> val
      end
    end)
    EEx.eval_file("lib/templates/tuple.eex", result: r)
  end

end

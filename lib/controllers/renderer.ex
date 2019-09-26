defmodule Elixirbot.Renderer do
  @moduledoc """
  Rendering Engine
  """
  def render_template(%ArgumentError{message: message}) do
    EEx.eval_file("lib/templates/error.eex", result: message)
  end

  def render_template(result) when is_function(result) do
    EEx.eval_file("lib/templates/error.eex", result: inspect result)
  end

  def render_template(result) do
    EEx.eval_file("lib/templates/result.eex", result: inspect result)
  end
end

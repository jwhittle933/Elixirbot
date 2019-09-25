defmodule Elixirbot.Renderer do
  @moduledoc """
  Rendering Engine
  """

  @doc """
  First line of defense render logic
  """
  def render_template(%ArgumentError{message: message}) do
    EEx.eval_file("lib/templates/error.eex", result: message)
  end

  def render_template({:module, moduleName, <<_::binary>>, _file}) do
    :code.delete(moduleName)
    EEx.eval_file("lib/templates/module.eex", name: moduleName)
  end

  def render_template(result) when is_function(result) do
    EEx.eval_file("lib/templates/error.eex", result: inspect result)
  end

  def render_template(result) do
    EEx.eval_file("lib/templates/string_or_number.eex", result: inspect result)
  end
end

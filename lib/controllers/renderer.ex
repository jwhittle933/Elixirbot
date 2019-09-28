defmodule Elixirbot.Renderer do
  @moduledoc """
  Rendering Engine
  """

  @error "Elixirbot> (UnsupportedError) <%= result %>\n"
  @result "Elixirbot> <%= result %>\n"

  def render_template(%ArgumentError{message: message}) do
    EEx.eval_string(@error, result: message)
  end

  def render_template(result) when is_function(result) do
    EEx.eval_string(@error, result: inspect result)
  end

  def render_template(result) do
    EEx.eval_string(@result, result: inspect result)
  end
end

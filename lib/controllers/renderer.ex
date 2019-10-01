defmodule Elixirbot.Renderer do
  @moduledoc """
  Rendering Engine
  """

  @error "```\nElixirbot> (UnsupportedError) <%= result %>\n```"
  @result "```\nElixirbot> <%= result %>\n```"

  def render(%ArgumentError{message: message}) do
    EEx.eval_string(@error, result: message)
  end

  def render(result) when is_function(result) do
    EEx.eval_string(@error, result: inspect result)
  end

  # def render(result) when is_binary(result) or is_integer(result) or is_float(result) do
  #   EEx.eval_string(@result, result: result)
  # end

  def render(result) do
    EEx.eval_string(@result, result: inspect result)
  end
end

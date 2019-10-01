defmodule Elixirbot.BotCode do
  @moduledoc """
  Module for code injection
  """
  alias Elixirbot.Renderer
  alias Elixirbot.Request

  @help "help
  Elixirbot [0.1.0] © Jonathan Whittle for use with _D\n
  Elixirbot is invoked by typing /helix followed by valid Elixir code.
  (Not Supported) /helix does not support and def* methods,
  \tdef, defmodule, defstruct, etc."

  def run(%Request{text: text}) do
    text
    |> parse_input
    |> Renderer.render
  end

  def parse_input(input) do
    case input do
      <<"def", _::binary>> -> "(Warning) No def* support in Elixirbot. Use iex for modular integration."
      <<"help", _::binary>> -> @help
      _ -> eval_code(input)
    end
  end

  def eval_code(exec) do
    {result, _} = Code.eval_string(exec)
    result
    rescue
      e in ArgumentError -> e
  end
end

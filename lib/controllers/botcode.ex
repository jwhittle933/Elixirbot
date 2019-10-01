defmodule Elixirbot.BotCode do
  @moduledoc """
  Module for code evaluation
  """
  alias Elixirbot.Renderer
  alias Elixirbot.Request

  @help "help
  Elixirbot [0.1.0] © 2019 Jonathan Whittle for use with _D\n
  (Unsupported) def, defmodule, defstruct, etc.\n
  Examples:\n
  /helix x = 10
  Elixirbot> 10\n
  /helix 10 == 10
  Elixirbot> true\n
  /helix List.first([1, 2, 3])
  Elixirbot> 1\n
  /helix Enum.map([2, 3, 4], fn x -> x * 2 end)
  Elixirbot> [4, 6, 8]\n
  /helix x = fn x -> x *10 end
  x.(30)
  Elixirbot> 300\n"

  def run(%Request{text: text}) do
    text
    |> no_execute?
    |> Renderer.render
  end

  def no_execute?(input) do
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

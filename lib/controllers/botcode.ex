defmodule Elixirbot.BotCode do
  @moduledoc """
  Module for code injection
  """
  alias Elixirbot.Renderer

  def start_link do
    GenServer.start_link(__MODULE__, [:ok])
  end

  def init([child_spec]) do
    {:ok, child_spec}
  end

  def run(%Plug.Conn{assigns: %{exec: exec}}) do
    exec
    |> defines?
    |> Renderer.render_template
  end

  def defines?(input) do
    case input do
      <<"def", _::binary>> -> "(Warning) No def* support in Elixirbot. Use iex for modular integration."
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

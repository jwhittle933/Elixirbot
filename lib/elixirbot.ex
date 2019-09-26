defmodule Elixirbot do
  @moduledoc """
  Documentation for Elixirbot.
  """
  use GenServer

  def start_link(child_spec) do
    GenServer.start_link(__MODULE__, [child_spec])
  end

  def init([child_spec]) do
    {:ok, child_spec}
  end
end

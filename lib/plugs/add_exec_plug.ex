defmodule Elixirbot.AddExecPlug do
  import Plug.Conn

  def init(opts), do: opts

  def call(%Plug.Conn{body_params: %{"exec" => exec}} = conn, _opts) do
    conn |> assign(:exec, exec)
  end
end

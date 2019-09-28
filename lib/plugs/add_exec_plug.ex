defmodule Elixirbot.AddExecPlug do
  import Plug.Conn
  alias Elixirbot.Request

  def init(opts), do: opts

  def call(%Plug.Conn{body_params: %{"exec" => exec}} = conn, _opts) do
    conn |> assign(:exec, exec)
  end

  def call(%Plug.Conn{params: %{"text" => exec}} = conn, _opts) do
    conn |> assign(:exec, exec)
  end
end


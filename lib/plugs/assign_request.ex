defmodule Elixirbot.AssignRequestPlug do
  import Plug.Conn
  alias Elixirbot.Request

  def init(opts), do: opts

  def call(%Plug.Conn{body_params: %{"exec" => exec}} = conn, _opts) do
    conn |> assign(:exec, exec)
  end

  def call(%Plug.Conn{params: params} = conn, _opts) do
    req = Request.new(params)
    IO.inspect req

    conn
    |> assign(:exec, req.text)
    |> assign(:request, req)
  end

  def call(conn, _opts), do: conn
end


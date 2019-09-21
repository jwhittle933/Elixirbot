defmodule Elixirbot.TemplatePlug do
  import Plug.Conn

  def init(opts), do: opts

  def call(%Plug.Conn{body_params: params} = conn, _opts) do
    conn |> assign(:exec, params)
  end

end


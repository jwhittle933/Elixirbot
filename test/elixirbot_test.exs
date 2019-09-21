defmodule ElixirbotTest do
  use ExUnit.Case
  use Plug.Test
  alias Elixirbot.Router
  doctest Elixirbot

  @opts Router.init([])

  test "Response" do
    conn = conn(:post, "/webhook", "") |> Router.call(@opts)


    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "Oh yeah"
  end
end

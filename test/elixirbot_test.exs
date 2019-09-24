defmodule ElixirbotTest do
  use ExUnit.Case
  use Plug.Test
  alias Elixirbot.Router
  doctest Elixirbot

  @opts Router.init([])


  describe "Variable Assignment" do
    test "User assigns a number" do
      conn = conn(:post, "/webhook", %{exec: "x = 11"}) |> Router.call(@opts)

      assert conn.state == :sent
      assert conn.status == 200
      assert conn.resp_body == "Elixirbot> 11\n"
    end


    test "User assigns a list" do
      conn = conn(:post, "/webhook", %{exec: "x = [1, 2, 3, 4]"}) |> Router.call(@opts)

      assert conn.state == :sent
      assert conn.status == 200
      assert conn.resp_body == "Elixirbot> [1, 2, 3, 4]\n"
    end

    test "User assigns a map" do
      conn = conn(:post, "/webhook", %{exec: "x = %{a: 1, b: 2}"}) |> Router.call(@opts)

      assert conn.state == :sent
      assert conn.status == 200
      assert conn.resp_body == "Elixirbot> %{a: 1, b: 2}\n"
    end

    test "User assigns a tuple" do
      conn = conn(:post, "/webhook", %{exec: "x = {:ok, 45}"}) |> Router.call(@opts)
      IO.inspect
      assert conn.state == :sent
      assert conn.status == 200
      # assert conn.resp_body == "Elixirbot> %{a: 1, b: 2}\n"
    end
  end

  end

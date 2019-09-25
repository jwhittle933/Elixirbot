defmodule ElixirbotTest do
  use ExUnit.Case
  use Plug.Test
  alias Elixirbot.Router
  doctest Elixirbot

  @opts Router.init([])


  describe "Variable Assignment" do
    test "User assigns a integer" do
      conn = conn(:post, "/webhook", %{exec: "x = 11"}) |> Router.call(@opts)

      assert conn.state == :sent
      assert conn.status == 200
      assert conn.resp_body == "Elixirbot> 11\n"
    end

    test "User assigns a float" do
      conn = conn(:post, "/webhook", %{exec: "x = 11.234"}) |> Router.call(@opts)

      assert conn.state == :sent
      assert conn.status == 200
      assert conn.resp_body == "Elixirbot> 11.234\n"
    end

    test "User assigns an atom" do
      conn = conn(:post, "/webhook", %{exec: "x = :ok"}) |> Router.call(@opts)

      assert conn.state == :sent
      assert conn.status == 200
      assert conn.resp_body == "Elixirbot> :ok\n"
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
      conn = conn(:post, "/webhook", %{exec: "x = {110, 45}"}) |> Router.call(@opts)

      assert conn.state == :sent
      assert conn.status == 200
      assert conn.resp_body == "Elixirbot> {110, 45}\n"

      conn = conn(:post, "/webhook", %{exec: "x = {:ok, 45}"}) |> Router.call(@opts)

      assert conn.state == :sent
      assert conn.status == 200
      assert conn.resp_body == "Elixirbot> {:ok, 45}\n"
    end

    test "User assigns a list of tuples" do
      conn = conn(:post, "/webhook", %{exec: "x = [{12, 12}, {13, 13}]"}) |> Router.call(@opts)

      assert conn.state == :sent
      assert conn.status == 200
      assert conn.resp_body == "Elixirbot> [{12, 12}, {13, 13}]\n"
    end

    test "User defines a function" do
      conn = conn(:post, "/webhook", %{exec: "def run do\n :ok\nend"}) |> Router.call(@opts)

      assert conn.state == :sent
      assert conn.status == 200
      assert conn.resp_body == "Elixirbot> (UnsupportedError) cannot invoke def/2 outside module\n"
    end

    test "User defines a module" do
      conn = conn(:post, "/webhook", %{exec: "defmodule Test do\nend"}) |> Router.call(@opts)

      assert conn.state == :sent
      assert conn.status == 200
      assert conn.resp_body == "Elixirbot> (Warning) New Module created: Elixir.Test. Elixirbot does not support module or function persistence.\n"
    end
  end

  describe "Evaluations" do
    test "Enum.map" do
      conn = conn(:post, "/webhook", %{exec: "Enum.map([1, 2, 3], fn x -> x * 2 end)"}) |> Router.call(@opts)

      assert conn.state == :sent
      assert conn.status == 200
      assert conn.resp_body == "Elixirbot> [2, 4, 6]\n"
    end

    test "assertion of truth" do
      conn = conn(:post, "/webhook", %{exec: "[1, 2, 3] == [1, 2, 3]"}) |> Router.call(@opts)

      assert conn.state == :sent
      assert conn.status == 200
      assert conn.resp_body == "Elixirbot> true\n"
    end
  end

  end

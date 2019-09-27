defmodule Elixirbot.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixirbot,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :slack, :eex],
      mod: {Elixirbot.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:slack, "~> 0.19.0"},
      {:plug, "~>1.8"},
      {:plug_cowboy, "~>2.0"},
      {:poison, "~>3.1"},
      {:httpoison, "~>1.5"},
      {:distillery, "~>2.0"},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end

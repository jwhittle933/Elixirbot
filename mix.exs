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
      {:jason, "~>1.1"},
      {:httpoison, "~>1.5"},
      {:hackney, github: "benoitc/hackney", override: true},
      {:distillery, "~>2.0"},
      {:ecto, "~>3.2.1"}
    ]
  end
end

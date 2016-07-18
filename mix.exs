defmodule NpmSearch.Mixfile do
  use Mix.Project

  def project do
    [app: :npm_search,
     version: "0.1.0",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger, :cowboy, :plug, :httpoison],
     mod: {NpmSearch, []}]
  end

  defp deps do
    [{:cowboy, "~> 1.0"},
     {:plug, "~> 1.1"},
     {:httpoison, "~> 0.9"},
     {:poison, "~> 2.2"}]
  end
end

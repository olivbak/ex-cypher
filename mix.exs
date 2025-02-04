defmodule ExCypher.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_cypher,
      description: "A DSL to interact with cypher query language",
      version: "0.3.1",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.html": :test,
        "coveralls.github": :test
      ],
      deps: deps(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.1.0", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.10", only: :test},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      name: "ex_cypher",
      licenses: ["MIT"],
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end

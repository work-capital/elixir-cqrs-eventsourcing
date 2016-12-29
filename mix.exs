defmodule Engine.Mixfile do
  use Mix.Project

  def project do
    [app: :workflow,
     version: "0.2.0",
     elixir: "~> 1.3",
     description: description(),
     package: package(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end


  def application do
    [applications: [:logger],
     mod: {Workflow, []}]
  end

  defp deps do
    [
      {:extreme, "~> 0.7.1"},    # eventstore driver
      # utils
      {:uuid, "~> 1.1.4" },
      {:logger_file_backend, "~> 0.0.9"},  # Save logs to file  [remmember to create a ~/logs directory!]
			# DEVs
			{:dogma, "~> 0.1.7", only: [:dev]},      # code linter
      {:dialyxir, "~> 0.3.5", only: [:dev]},   # simplify dialyzer, type: mix dialyzer.plt first
			{:mix_test_watch, "~> 0.2", only: :dev}, # use mix test.watch for TDD development
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end


  defp package do
    [# These are the default files included in the package
     name: :workflow,
     files: ["lib", "test", "config", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["Henry Hazan", "Shmuel Kalmus"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/work-capital/engine"}]
  end


   defp description do
    """
    Building Blocks to write CQRS Event Sourcing apps in Elixir
    """
  end


end

defmodule Ecta.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecta,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :odbc]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:unidecode, "~> 1.0.0"}
    ]
  end
end

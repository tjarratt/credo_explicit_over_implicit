defmodule CredoExplicitOverImplicit.MixProject do
  use Mix.Project

  @github_url "https://github.com/tjarratt/credo_explicit_over_implicit"

  def project do
    [
      app: :credo_explicit_over_implicit,
      name: "CredoExplicitOverImplicit",
      description:
        "Provides Credo checks that optimize for making code explicit rather than implicit",
      version: "1.2.0",
      elixir: "~> 1.19",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.7", runtime: false}
    ]
  end

  defp package() do
    [
      files: ~w[
        README.*
        lib
        LICENSE
        mix.exs
      ],
      licenses: ["MIT"],
      links: %{"GitHub" => @github_url},
      maintainers: ["Tim Jarratt"]
    ]
  end

  defp docs() do
    [
      main: "readme",
      extras: [{:"README.md", [title: "Overview"]}],
      source_url: @github_url
    ]
  end
end

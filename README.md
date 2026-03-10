# CredoExplicitOverImplicit

Provides custom credo checks for those that prefer explicit over implicit. 
Broadly this is already the case in elixir, compared to other languages such as ruby,
but there are still some rough edges to the language that can make maintenance harder.

Currently this provides a single credo check 

- CredoExplicitOverImplicit.Imports

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `credo_explicit_over_implicit` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:credo_explicit_over_implicit, "~> 0.1.0"},
    {:credo, "~> 1.7", runtime: false},
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/credo_explicit_over_implicit>.


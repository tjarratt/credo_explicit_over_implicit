defmodule CredoExplicitOverImplicit.ImportsTest do
  use Credo.Test.Case, async: true

  alias CredoExplicitOverImplicit.Imports

  setup do
    {:ok, _} = Application.ensure_all_started(:credo)

    :ok
  end

  test "reports when a module uses blank import statements" do
    """
    defmodule CheekyModule do
      import BadModule
      import GoodModule, only: [my_func: 1]
    end
    """
    |> to_source_file()
    |> run_check(Imports)
    |> assert_issue(fn issue ->
      assert issue.scope == "CheekyModule"
      assert issue.trigger == "import"
      assert issue.line_no == 2
    end)
  end

  test "reports when a module uses the :except option" do
    """
    defmodule CheekyModule do
      import GoodModule, only: [my_func: 1]
      import BadModule, except: [not_this: 1]
    end
    """
    |> to_source_file()
    |> run_check(Imports)
    |> assert_issue(fn issue ->
      assert issue.scope == "CheekyModule"
      assert issue.trigger == "import"
      assert issue.line_no == 3
    end)
  end

  test "handles modules with namespaces" do
    """
    defmodule CheekyModule do
      import Good.Module, only: [my_func: 1]
      import Bad.Module
    end
    """
    |> to_source_file()
    |> run_check(Imports)
    |> assert_issue(fn issue ->
      assert issue.scope == "CheekyModule"
      assert issue.trigger == "import"
      assert issue.line_no == 3
    end)
  end

  test "does not report when imports are made explicitly with only" do
    """
    defmodule CheekyModule do
      import GoodModule, only: [my_func: 1]
    end
    """
    |> to_source_file()
    |> run_check(Imports)
    |> refute_issues()
  end
end

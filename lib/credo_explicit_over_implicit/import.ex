defmodule CredoExplicitOverImplicit.Imports do
  use Credo.Check, category: :warning

  @impl Credo.Check
  def run(%SourceFile{} = source_file, params) do
    issue_meta = IssueMeta.for(source_file, params)

    Credo.Code.prewalk(source_file, &traverse(&1, &2, issue_meta))
  end

  defp traverse({:import, _import_attrs, import_statements} = ast, issues, issue_meta) do
    new_issues =
      import_statements
      |> identify_implicit_imports(issue_meta)

    {ast, issues ++ new_issues}
  end

  defp traverse(ast, issues, _issue_meta) do
    {ast, issues}
  end

  defp identify_implicit_imports([{:__aliases__, attrs, _module_alias}], issue_meta) do
    [
      format_issue(issue_meta,
        message: "Use explicit imports with :only rather than implicit imports",
        line_no: Keyword.get(attrs, :line),
        trigger: :import
      )
    ]
  end

  defp identify_implicit_imports(
         [{:__aliases__, attrs, _module_alias}, [except: _explicit_imports]],
         issue_meta
       ) do
    [
      format_issue(issue_meta,
        message: "Use explicit imports with :only rather than implicit imports",
        line_no: Keyword.get(attrs, :line),
        trigger: :import
      )
    ]
  end

  defp identify_implicit_imports(
         [{:__aliases__, _last_attrs, _module_alias}, [only: _explicit_imports]],
         _issue_meta
       ) do
    []
  end

  defp identify_implicit_imports(
         [{:__aliases__, _last_attrs, _module_alias}, unknown],
         _issue_meta
       ) do
    raise "Unexpected AST : #{inspect(unknown)}\nPlease report this as a bug https://github.com/tjarratt/credo_explicit_over_implicit"
  end
end

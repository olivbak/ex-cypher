defmodule ExCypher.Statement do
  @moduledoc false

  alias ExCypher.Statements.{Generic, Order, Set, Where, With, Escape}

  # Cypher syntax varies depending on the statement being used. For example,
  # the `WHERE` statement's syntax can vary a lot when compared to simpler
  # `RETURN` statements.

  # This way, there's no point on creating an extense library with several
  # pattern matching conditions when some of them shouldn't be applied to
  # statements like `RETURN` or `LIMIT`.

  # This module splits the syntax parsing into submodules, making it easier to
  # check, maintain and improve the support to the Cypher language in this
  # library.

  @type command_name :: atom

  @spec parse(cmd_name :: String.t(), ast :: term(), Macro.Env.t()) ::
          String.t() | list()
  def parse(:where, ast, env) do
    ["WHERE", Where.parse(ast, env)]
  end

  def parse(:order, ast, env) do
    ["ORDER BY", Order.parse(ast, env)]
  end

  def parse(:pipe_with, ast, env) do
    ["WITH", With.parse(ast, env)]
  end

  def parse(:set, ast, env) do
    ["SET", Set.parse(ast, env)]
  end

  def parse(:optional_match, ast, env) do
    ["OPTIONAL MATCH", Generic.parse(ast, env)]
  end

  def parse(:escape, ast, env) do
    IO.puts("AST: #{inspect(ast)}")
    IO.puts("AST flat: #{inspect(List.flatten(ast))}")
    ["", Escape.parse(List.flatten(ast), env)]
  end

  def parse(command_name, ast, env) do
    command_name =
      command_name
      |> Atom.to_string()
      |> String.upcase()

    [command_name, Generic.parse(ast, env)]
  end
end

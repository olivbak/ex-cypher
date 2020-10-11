defmodule ExCypher.Statements.Generic.Expression do
  @moduledoc """
    A module to abstract the AST format into something mode human-readable
  """

  defstruct [:type, :env, :args]

  def new(ast, env) do
    checkers = [
      &as_fragment/1,
      &as_property/1,
      &as_node/1,
      &as_relationship/1,
      &as_association/1,
      &another_term/1
    ]

    Enum.find_value(checkers, fn checker -> checker.({ast, env}) end)
  end

  defp as_fragment({ast, env}) do
    case ast do
      {:fragment, _ctx, args} ->
        %__MODULE__{type: :fragment, args: args, env: env}

      _ ->
        nil
    end
  end

  defp as_property({ast, env}) do
    case ast do
      {{:., _, [first, last | []]}, _, _} ->
        %__MODULE__{type: :property, args: [first, last], env: env}

      _ ->
        nil
    end
  end

  defp as_node({ast, env}) do
    case ast do
      {:node, _ctx, args} ->
        %__MODULE__{type: :node, args: args, env: env}

      _ ->
        nil
    end
  end

  defp as_relationship({ast, env}) do
    case ast do
      {:rel, _ctx, args} ->
        %__MODULE__{type: :relationship, args: args, env: env}
      _ ->
        nil
    end
  end

  defp as_association({ast, env}) do
    case ast do
      {association, _ctx, [from, to]} ->
        %__MODULE__{
          type: :association,
          args: [association, {from, to}],
          env: env
        }
      _ ->
        nil
    end
  end

  defp another_term({ast, env}) do
    cond do
      is_nil(ast) ->
        %__MODULE__{type: :null, args: nil, env: env}

      is_atom(ast) ->
        %__MODULE__{type: :alias, args: ast, env: env}

      is_list(ast) ->
        %__MODULE__{type: :list, args: ast, env: env}

      variable?(ast) ->
        %__MODULE__{type: :var, args: ast, env: env}

      true ->
        %__MODULE__{type: :other, args: ast, env: env}
    end
  end

  defp variable?({var_name, _ctx, nil}), do: is_atom(var_name)
  defp variable?(_), do: false
end

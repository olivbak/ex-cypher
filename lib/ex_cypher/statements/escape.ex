defmodule ExCypher.Statements.Escape do
  @moduledoc false

  def parse([x | xs], env) when is_binary(x) do
    IO.puts("match list, X: #{inspect(x)} ,,, XS: #{inspect(xs)}")
    [x | parse(xs, env)]
  end

  def parse(_raw_str, _env) do
    IO.puts("match err")
    []
  end

end

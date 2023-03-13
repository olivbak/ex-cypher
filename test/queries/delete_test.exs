defmodule Queries.DeleteTest do
  use ExUnit.Case

  import ExCypher

  describe "deletes" do
    test "deletes a single element" do
      assert "DELETE n" = cypher(do: delete(:n))
    end

    test "deletes multiple elements" do
      assert "DELETE m, n, o" = cypher(do: delete(:m, :n, :o))
    end


    test "map in do block" do
      esc1 = Enum.map([:a,:b,:c], fn x ->
	"MATCH #{inspect(x)} with"
      end)

      esc1 
      |> Enum.map(fn x -> IO.puts("OUT: #{inspect(x)}") end)

      IO.puts("ESC1: #{inspect(esc1)}")
      
      res = cypher do
	escape(["hej", "nej", "lej"])
      end

      assert "hej nej lej" == res

    end


  end
end

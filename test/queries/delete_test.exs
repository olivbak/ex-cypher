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

  end
end

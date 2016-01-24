defmodule Calculator.ParserTest do
  use ExUnit.Case, async: true
  alias Calculator.Parser

  test "structures a basic operation" do
    tokens = [8,{:operator, :plus}, 9]
    assert Parser.parse(tokens) == {:plus, 8, 9}
  end

  test "nests multiple operations" do
    tokens = [
      1,
      {:operator, :plus},
      2,
      {:operator, :minus},
      3
    ]
    assert Parser.parse(tokens) == {:plus, 1, {:minus, 2, 3}}
  end
end

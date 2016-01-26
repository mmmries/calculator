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

  test "order of operations" do
    tokens = [
      1,
      {:operator, :plus},
      8,
      {:operator, :multiply},
      8,
      {:operator, :plus},
      1
    ]

    assert Parser.parse(tokens) == {:plus, 1, {:plus, {:multiply, 8, 8}, 1}}
  end

  test "parentheses change the order of operations" do
    tokens = [
      :open_parenthesis,
      1,
      {:operator, :plus},
      8,
      :close_parenthesis,
      {:operator, :multiply},
      8,
      {:operator, :plus},
      1
    ]

    assert Parser.parse(tokens) == {:plus, {:multiply, {:plus, 1, 8}, 8}, 1}
  end
end

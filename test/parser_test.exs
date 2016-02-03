defmodule Calculator.ParserTest do
  use ExUnit.Case, async: true
  alias Calculator.Parser

  test "handles a simple number" do
    assert Parser.parse([5]) == 5
  end

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
    assert Parser.parse(tokens) == {:minus, {:plus, 1, 2}, 3}
  end

  test "order of operations" do
    tokens = [
      1,
      {:operator, :minus},
      8,
      {:operator, :multiply},
      8,
      {:operator, :minus},
      1
    ]

    assert Parser.parse(tokens) == {:minus, {:minus, 1, {:multiply, 8, 8}}, 1}
  end

  @tag :pending
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

  @tag :pending
  test "nested parentheses support" do
    tokens = [
      2,
      {:operator, :minus},
      :open_parenthesis,
      8,
      {:operator, :divide},
      :open_parenthesis,
      6,
      {:operator, :minus},
      2,
      :close_parenthesis,
      :close_parenthesis,
      {:operator, :plus},
      3,
    ]

    assert Parser.parse(tokens) == {:minus, 2, {:plus, {:divide, 8, {:minus, 6, 2}}, 3}}
  end
end

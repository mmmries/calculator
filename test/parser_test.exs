defmodule Calculator.ParserTest do
  use ExUnit.Case, async: true
  alias Calculator.Parser

  test "structures a basic operation" do
    tokens = [8,{:operator, :plus}, 9]
    assert Parser.parse(tokens) == {:plus, 8, 9}
  end
end

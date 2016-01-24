defmodule Calculator.TokenizerTest do
  use ExUnit.Case, async: true
  alias Calculator.Tokenizer

  test "tokenize a literal" do
    assert Tokenizer.tokenize("5") == [5]
  end

  test "tokenize an operator" do
    assert Tokenizer.tokenize("+") == [{:operator, :plus}]
  end

  test "tokenize a basic addition" do
    assert Tokenizer.tokenize("31+88") == [31, {:operator, :plus}, 88]
  end
end

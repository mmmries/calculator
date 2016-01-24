defmodule Calculator.TokenizerTest do
  use ExUnit.Case, async: true
  alias Calculator.Tokenizer

  test "tokenize a literal" do
    assert Tokenizer.tokenize("5") == [5]
  end

  test "tokenize operators" do
    assert Tokenizer.tokenize("+") == [{:operator, :plus}]
    assert Tokenizer.tokenize("-") == [{:operator, :minus}]
    assert Tokenizer.tokenize("*") == [{:operator, :multiply}]
    assert Tokenizer.tokenize("/") == [{:operator, :divide}]
  end

  test "tokenize a basic addition" do
    assert Tokenizer.tokenize("31 + 88") == [31, {:operator, :plus}, 88]
  end

  test "tokenize paranethesized expression" do
    assert Tokenizer.tokenize("( 8 / 5 ) + 3") == [:open_parenthesis, 8, {:operator, :divide}, 5, :close_parenthesis, {:operator, :plus}, 3]
  end
end

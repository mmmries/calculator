defmodule Calculator.TokenizerTest do
  use ExUnit.Case, async: true
  alias Calculator.Tokenizer

  test "tokenize a literal" do
    assert Tokenizer.tokenize("58") == [58]
  end

  test "tokenize an operator" do
    assert Tokenizer.tokenize("+") == [{:operator, :plus}]
  end
end
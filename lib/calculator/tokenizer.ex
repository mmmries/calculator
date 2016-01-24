defmodule Calculator.Tokenizer do
  def tokenize("+") do
    [{:operator, :plus}]
  end

  def tokenize(str) do
    [String.to_integer(str)]
  end
end

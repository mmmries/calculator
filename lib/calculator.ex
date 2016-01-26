defmodule Calculator do
  def evaluate(expression) do
    expression
    |> Calculator.Tokenizer.tokenize
    |> Calculator.Parser.parse
    |> Calculator.Evaluator.evaluate
  end
end

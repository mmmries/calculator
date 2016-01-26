defmodule Calculator.Evaluator do
  def evaluate(a) when is_number(a), do: a
  def evaluate({:plus, a, b}), do: evaluate(a) + evaluate(b)
  def evaluate({:minus, a, b}), do: evaluate(a) - evaluate(b)
  def evaluate({:multiply, a, b}), do: evaluate(a) * evaluate(b)
  def evaluate({:divide, a, b}), do: evaluate(a) / evaluate(b)
end

defmodule Calculator do
  @regex ~r{(\d+)\s*([\+\-\*])\s*(\d+)}

  def evaluate(expression) do
    [_match, a, operator, b] = Regex.run(@regex, expression)
    calculate(String.to_integer(a), String.to_integer(b), operator)
  end

  defp calculate(a, b, "+") do
    a + b
  end

  defp calculate(a, b, "-") do
    a - b
  end

  defp calculate(a, b, "*") do
    a * b
  end
end

defmodule Calculator do
  @regex ~r{(\d+)\s*([\+\-\*])\s*(\d+)}

  def evaluate(expression) do
    matches = Regex.run(@regex, expression)
    a = Enum.at(matches, 1)
    operator = Enum.at(matches, 2)
    b = Enum.at(matches, 3)
    calculate(String.to_integer(a), String.to_integer(b), operator)
  end

  defp calculate(a, b, operator) do
    case operator do
      "+" -> a + b
      "-" -> a - b
      "*" -> a * b
    end
  end
end

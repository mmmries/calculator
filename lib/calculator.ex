defmodule Calculator do
  @regex ~r{(\d+)\s*\+\s*(\d+)}

  def evaluate(expression) do
    matches = Regex.run(@regex, expression)
    a = Enum.at(matches, 1)
    b = Enum.at(matches, 2)
    String.to_integer(a) + String.to_integer(b)
  end
end

defmodule Calculator.Parser do
  def parse([a, {:operator, op} | rest]) do
    {op, parse([a]), parse(rest)}
  end
  def parse([a]) when is_number(a) do
    a
  end
end

defmodule Calculator.Parser do
  def parse([a, {:operator, op}, b]) when is_number(a) and is_number(b) do
    {op, a, b}
  end
end

defmodule Calculator.Parser do
  def parse([a]) when is_number(a), do: a
  def parse([{_op, _left, _right}=ast]), do: ast
  def parse(tokens) do
    [ast] = tokens
            |> collapse_operator(:divide)
            |> collapse_operator(:multiply)
            |> collapse_operator(:plus)
            |> collapse_operator(:minus)
    ast
  end

  defp collapse_operator([], _op), do: []
  defp collapse_operator([left, {:operator, operator}, right | rest], operator) do
    collapse_operator([{operator, left, right} | rest], operator)
  end
  defp collapse_operator([head | rest], operator) do
    [head | collapse_operator(rest, operator)]
  end
end

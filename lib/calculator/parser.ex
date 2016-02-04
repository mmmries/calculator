defmodule Calculator.Parser do
  def parse([a]) when is_number(a), do: a
  def parse([{_op, _left, _right}=ast]), do: ast
  def parse(tokens) do
    [ast] = tokens
            |> collapse_parens
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

  defp collapse_parens([]), do: []
  defp collapse_parens([:open_parenthesis | rest]) do
    {inside_parens, rest} = split_on(rest, :close_parenthesis)
    [parse(inside_parens) | collapse_parens(rest)]
  end
  defp collapse_parens([head | tail]), do: [head | collapse_parens(tail)]

  defp split_on(list, item), do: split_on([], list, item)
  defp split_on(left, [], _item), do: {Enum.reverse(left), []}
  defp split_on(left, [item | rest], item), do: {Enum.reverse(left), rest}
  defp split_on(left, [head | rest], item), do: split_on([head | left], rest, item)
end

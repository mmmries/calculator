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
    {inside_parens, rest} = scan_balanced_paren([], rest, 0)
    [parse(inside_parens) | collapse_parens(rest)]
  end
  defp collapse_parens([head | tail]), do: [head | collapse_parens(tail)]

  defp scan_balanced_paren(left, [:close_parenthesis | rest], 0), do: {Enum.reverse(left), rest}
  defp scan_balanced_paren(left, [:close_parenthesis | rest], depth) do
    scan_balanced_paren([:close_parenthesis | left], rest, depth - 1)
  end
  defp scan_balanced_paren(left, [:open_parenthesis | rest], depth) do
    scan_balanced_paren([:open_parenthesis | left], rest, depth + 1)
  end
  defp scan_balanced_paren(left, [head | rest], depth), do: scan_balanced_paren([head | left], rest, depth)
end

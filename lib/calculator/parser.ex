defmodule Calculator.Parser do
  def parse([a]) when is_number(a), do: a
  def parse([{_op, _left, _right}=ast]), do: ast
  def parse(tokens) do
    [ast] = tokens
            |> collapse_parens
            |> collapse_operators([:divide, :multiply])
            |> collapse_operators([:plus, :minus])
    ast
  end

  defp collapse_operators([], _op), do: []
  defp collapse_operators([left, {:operator, operator}, right | rest]=tokens, operators) do
    case operator in operators do
      true -> collapse_operators([{operator, left, right} | rest], operators)
      false ->
        [head | rest] = tokens
        [head | collapse_operators(rest, operators)]
    end
  end
  defp collapse_operators([head | rest], operators) do
    [head | collapse_operators(rest, operators)]
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

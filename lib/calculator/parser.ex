defmodule Calculator.Parser do
  def parse([a]) when is_number(a), do: a
  def parse([{_operation, _left, _right}=ast]), do: ast
  def parse(tokens) do
    tokens
    |> collapse_parens
    |> parse_operations
  end

  defp collapse_parens([]), do: []
  defp collapse_parens([:open_parenthesis | tail]) do
    {inside_parens, rest} = scan_for_matching_parenthesis(tail, 0, [])
    [parse(inside_parens) | collapse_parens(rest)]
  end
  defp collapse_parens([head | tail]) do
    [head | collapse_parens(tail)]
  end

  defp parse_operations(tokens) do
    case split_on(tokens, [:plus, :minus]) do
      {left, operator, right} ->
        {operator, parse(left), parse(right)}
      tokens ->
        {left, operator, right} = split_on(tokens, [:multiply, :divide])
        {operator, parse(left), parse(right)}
    end
  end

  defp scan_for_matching_parenthesis([:close_parenthesis | tail], 0, inside_parens) do
    {Enum.reverse(inside_parens), tail}
  end
  defp scan_for_matching_parenthesis([:open_parenthesis | tail], depth, inside_parens) do
    scan_for_matching_parenthesis(tail, depth+1, [:open_parenthesis | inside_parens])
  end
  defp scan_for_matching_parenthesis([:close_parenthesis | tail], depth, inside_parens) do
    scan_for_matching_parenthesis(tail, depth-1, [:close_parenthesis | inside_parens])
  end
  defp scan_for_matching_parenthesis([head | tail], depth, inside_parens) do
    scan_for_matching_parenthesis(tail, depth, [head | inside_parens])
  end

  # if we find one of the selected operators we'll return {left, operator, right}
  # left and right are the lists of tokens to the left or right of the operator we found
  defp split_on(tokens, operators) do
    split_on([], operators, tokens)
  end

  defp split_on(left, _operators, []), do: Enum.reverse(left)
  defp split_on(left, operators, [{:operator, op} | rest]) do
    if op in operators do
      {Enum.reverse(left), op, rest}
    else
      split_on([{:operator, op}|left], operators, rest)
    end
  end
  defp split_on(left, operators, [head | tail]), do: split_on([head | left], operators, tail)
end

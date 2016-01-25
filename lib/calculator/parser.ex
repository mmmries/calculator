defmodule Calculator.Parser do
  def parse([a]) when is_number(a), do: a
  def parse(tokens) do
    case split_on(tokens, [:plus, :minus]) do
      {left, operator, right} ->
        {operator, parse(left), parse(right)}
      tokens ->
        {left, operator, right} = split_on(tokens, [:multiply, :divide])
        {operator, parse(left), parse(right)}
    end
  end

  # if we find one of the selected operators we'll return {left, operator, right}
  # left and right are the lists of tokens to the left or right of the operator we found
  defp split_on(tokens, operators) do
    split_on([], operators, tokens)
  end

  defp split_on(left, _operators, []), do: left
  defp split_on(left, operators, [{:operator, op} | rest]) do
    if op in operators do
      {left, op, rest}
    else
      split_on([{:operator, op}|left], operators, rest)
    end
  end
  defp split_on(left, operators, [head | tail]), do: split_on([head | left], operators, tail)
end

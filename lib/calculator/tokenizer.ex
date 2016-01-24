defmodule Calculator.Tokenizer do
  def tokenize(str) do
    chunks = String.split(str, ~r/\b/)
    convert_list(chunks)
  end

  defp convert_list([]), do: []
  defp convert_list(["" | rest]), do: convert_list(rest)
  defp convert_list([chunk | rest]) do
    converted = convert_chunk(chunk)
    rest_converted = convert_list(rest)
    [converted | rest_converted]
  end

  def convert_chunk("+"), do: {:operator, :plus}
  def convert_chunk(str), do: String.to_integer(str)
end

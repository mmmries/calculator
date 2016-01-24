defmodule Calculator.Tokenizer do
  def tokenize(str) do
    chunks = String.split(str, ~r/\b/)
    tokens = Enum.map(chunks, &convert_chunk/1)
    Enum.reject(tokens, &is_nil/1)
  end

  def convert_chunk(""), do: nil
  def convert_chunk("+"), do: {:operator, :plus}
  def convert_chunk(str), do: String.to_integer(str)
end

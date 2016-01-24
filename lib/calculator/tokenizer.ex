defmodule Calculator.Tokenizer do
  def tokenize(str) do
    chunks = String.split(str, ~r/\b/)
    tokens = Enum.map(chunks, fn(chunk) -> convert_chunk(chunk) end)
    Enum.filter(tokens, fn(nil) -> false
                          (token) -> true end)
  end

  def convert_chunk(""), do: nil
  def convert_chunk("+"), do: {:operator, :plus}
  def convert_chunk(str), do: String.to_integer(str)
end

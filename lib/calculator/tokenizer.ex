defmodule Calculator.Tokenizer do
  def tokenize(str) do
    str
    |> String.split(~r/\b/)
    |> Enum.map(&convert_chunk/1)
    |> Enum.reject(&is_nil/1)
  end

  def convert_chunk(""), do: nil
  def convert_chunk("+"), do: {:operator, :plus}
  def convert_chunk("-"), do: {:operator, :minus}
  def convert_chunk("*"), do: {:operator, :multiply}
  def convert_chunk("/"), do: {:operator, :divide}
  def convert_chunk(str), do: String.to_integer(str)
end

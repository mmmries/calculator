defmodule CalculatorTest do
  use ExUnit.Case
  doctest Calculator

  test "calculate a basic addition expression`" do
    assert Calculator.evaluate("1 + 1") == 2
  end

  test "calculate different addition" do
    assert Calculator.evaluate("1+2") == 3
  end
end

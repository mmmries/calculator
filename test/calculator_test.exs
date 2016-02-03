defmodule CalculatorTest do
  use ExUnit.Case
  doctest Calculator

  test "calculate a basic addition expression`" do
    assert Calculator.evaluate("1 + 1") == 2
  end

  test "calculate different addition" do
    assert Calculator.evaluate("1 + 2") == 3
  end

  test "calculate a basic subtraction expression" do
    assert Calculator.evaluate("5 - 6") == -1
  end

  test "basic multiplication" do
    assert Calculator.evaluate("7 * 8") == 56
  end

  test "basic division" do
    assert Calculator.evaluate("14 / 2") == 7.0
  end

  test "parenthesized expression" do
    assert Calculator.evaluate("1 + ( 2 * 3 ) - ( 4 * 5 )") == -13
  end

  test "nested parentheses" do
    assert Calculator.evaluate("25 + ( ( 8 + 5 ) * 2 ) + 1 * 3") == 54
  end

  test "ordered operations" do
    assert Calculator.evaluate("10 - 3 - 2 - 1") == 4
  end
end

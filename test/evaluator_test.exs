defmodule Calculator.EvaluatorTest do
  use ExUnit.Case, async: true
  alias Calculator.Evaluator

  test "evaluates the simplest expression" do
    assert Evaluator.evaluate({:plus, 1, 1}) == 2
  end

  test "evaluate a complex expression" do
    ast = {:minus, {:multiply, {:plus, 3, 4}, 2},
           {:minus, 6, {:minus, {:multiply, 1, 3}, 5}}}
    assert Evaluator.evaluate(ast) == 6
  end
end

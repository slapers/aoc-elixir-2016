defmodule AdventofcodeTest.DayTwo do
  use ExUnit.Case

  test "move moves to the key above" do

    assert {1,2} == AdventOfCode.DayTwo.move("U", {1,1})
    assert {1,2} == AdventOfCode.DayTwo.move("U", {1,2})
  end

  test "part1 reveals the code" do
    assert [3, 5, 7, 4, 9] == AdventOfCode.DayTwo.part1()
  end

end
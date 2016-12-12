defmodule AdventofcodeTest.DayTwo do
  use ExUnit.Case

  @keypad1 {{'','','','',''},
            {'', 1, 2, 3,''},
            {'', 4, 5, 6,''},
            {'', 7, 8, 9,''},
            {'','','','',''}}

  test "move moves to the key above" do

    assert {2,1} == AdventOfCode.DayTwo.move("U", @keypad1, {2,2})
    assert {2,1} == AdventOfCode.DayTwo.move("U", @keypad1, {2,1})
  end

  test "part1 reveals the code" do
    assert [3, 5, 7, 4, 9] == AdventOfCode.DayTwo.part1()
  end

end

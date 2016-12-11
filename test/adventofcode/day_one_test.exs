defmodule AdventofcodeTest.DayOne do
  use ExUnit.Case

  test "parse_movement returns right" do
    {dir, _} = AdventOfCode.DayOne.parse_movement("R10")
    assert dir == :right
  end

  test "parse_movement returns left" do
    {dir, _} = AdventOfCode.DayOne.parse_movement("L10")
    assert dir == :left
  end

  test "parse_movement returns the correct amount" do
    {_, amount} = AdventOfCode.DayOne.parse_movement("R100")
    assert amount == 100
  end

  test "update_state updates correctly when going right" do
    {heading, _,_} = AdventOfCode.DayOne.update("R10", {:north, 0,0})
    assert heading == :east

    {heading, _,_} = AdventOfCode.DayOne.update("R10", {:east, 0,0})
    assert heading == :south

    {heading, _,_} = AdventOfCode.DayOne.update("R10", {:south, 0,0})
    assert heading == :west

    {heading, _,_} = AdventOfCode.DayOne.update("R10", {:west, 0,0})
    assert heading == :north
  end

  test "update_position updates correctly when going left" do
    {heading, _,_} = AdventOfCode.DayOne.update("L10", {:north, 0,0})
    assert heading == :west

    {heading, _,_} = AdventOfCode.DayOne.update("L10",{:east, 0,0})
    assert heading == :north

    {heading, _,_} = AdventOfCode.DayOne.update("L10",{:south, 0,0})
    assert heading == :east

    {heading, _,_} = AdventOfCode.DayOne.update("L10",{:west, 0,0})
    assert heading == :south
  end

  test "the solution to day one (part1)" do
    assert 250 == AdventOfCode.DayOne.part1()
  end

  test "the solution to day one (part2)" do
    assert 151 == AdventOfCode.DayOne.part2()
  end


end

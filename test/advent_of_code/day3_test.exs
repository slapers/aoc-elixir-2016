defmodule AdventOfCodeTest.Day3 do
  use ExUnit.Case

  test "part1 returns the correct result" do
    assert 917 == AdventOfCode.Day3.part1()
  end

  test "transpose transposes a matrix" do
    assert [[1,3],[2,4]] == AdventOfCode.Day3.transpose([[1,2],[3,4]])
    assert [[1,2]] == AdventOfCode.Day3.transpose([[1],[2]])
  end

  test "part2 returns the correct result" do
    assert 1649 == AdventOfCode.Day3.part2()
  end


  # Just getting a feel on for-comps
  #
  test "for comprehension" do
    matrix = [
      [1,2,3],
      [4,5,6],
      [7,8,9]
    ]
    assert 45  == (for row <- matrix, el <- row, do: el) |> Enum.sum
  end

end

defmodule AdventOfCodeTest.Day4 do
  use ExUnit.Case

  alias AdventOfCode.Day4, as: D4

  test "parse_room parses a room" do
    D4.parse_room("aaaaa-bbb-z-y-x-123[abxyz]") # {:decoy|:real, name, sector, csum}
    |> IO.inspect()
  end

  test "calculate_hash creates a correct hash" do
    assert "acnvb" == D4.calculate_hash("aaazbcvvanncyw")
  end

  test "part1 yields the correct result" do
    assert 185371 == D4.part1() |> IO.inspect()
  end

  test "part2 yields the correct result" do
    assert 984 == D4.part2() |> IO.inspect()
  end

end

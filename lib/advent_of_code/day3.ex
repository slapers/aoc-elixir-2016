defmodule AdventOfCode.DayThree do

  alias AdventOfCode.Common

  def parse_file() do
    Common.read_file(3)
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.filter(fn(x) -> x != "" end)
    |> Enum.map(fn(line) ->
        String.split(line)
        |> Enum.map(&String.to_integer/1)
        end)
  end

  def sort_row(row) do
    row
    |> Enum.sort()
  end

  def part1() do
    parse_file()
    |> Enum.map(&sort_row/1)
    |> Enum.filter(fn([a,b,c]) -> a + b > c end)
    |> Enum.count()
  end

  def part2() do
    parse_file()
    |> Enum.take
  end

end

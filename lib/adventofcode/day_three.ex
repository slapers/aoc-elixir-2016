defmodule AdventOfCode.DayThree do

  @filename "./lib/adventofcode/resource/day_three.txt"

  def parse_file() do
    File.read!(@filename)
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.filter(fn(x) -> x != "" end)
    |> Enum.map(fn(line) ->
        String.split(line)
        |> Enum.map(&String.to_integer/1)
        |> Enum.sort()
        end)
  end
  def part1() do
    parse_file()
    |> Enum.filter(fn([a,b,c]) -> a + b > c end)
    |> Enum.reduce(0, fn(_, a) -> a+1 end)
    |> IO.inspect()
  end

end

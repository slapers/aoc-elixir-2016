defmodule AdventOfCode.Day3 do

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

  # http://stackoverflow.com/questions/23705074/is-there-a-transpose-function-in-elixir
  def transpose([[]|_]), do: []
  def transpose(a) do
    [Enum.map(a, &hd/1) | transpose(Enum.map(a, &tl/1))]
  end

  def part2() do
    parse_file()
    |> transpose
    |> IO.inspect()
  end

end

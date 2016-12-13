defmodule AdventOfCode.Day3 do

  alias AdventOfCode.Common

  def parse_file() do
    Common.read_file(3)
    |> Enum.map(fn(line) ->
        String.split(line)
        |> Enum.map(&String.to_integer/1)
        end)
  end

  def transpose(lists) do
    List.zip(lists) |> Enum.map(&Tuple.to_list/1)
  end

  def sort_lists(lists) do
    Enum.map(lists, &Enum.sort/1)
  end

  def part1() do
    parse_file()
    |> sort_lists
    |> Enum.filter(fn([a,b,c]) -> a + b > c end)
    |> Enum.count()
  end

  def part2() do
    for lines <- parse_file() |> transpose do
      lines
      |> Enum.chunk(3)
      |> sort_lists
      |> Enum.filter(fn([a,b,c]) -> a + b > c end)
      |> Enum.count
    end
    |> Enum.sum()
  end
end

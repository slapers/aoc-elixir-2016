defmodule AdventOfCode.Common do

  def read_file(num) do
    File.read!("./lib/advent_of_code/inputs/day#{num}.txt")
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.filter(fn ln -> ln !== "" end)
  end
end

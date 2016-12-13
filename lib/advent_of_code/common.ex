defmodule AdventOfCode.Common do

  def read_file(num) do
    File.read!("./lib/advent_of_code/inputs/day#{num}.txt")
  end
end

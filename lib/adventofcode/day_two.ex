defmodule AdventOfCode.DayTwo do

  @part1_file "./lib/adventofcode/resource/day_two.txt"
  @keypad1 {{7,8,9},
            {4,5,6},
            {1,2,3}}

  def move(dir, coordinates) do
    max_y = tuple_size(@keypad1) - 1
    max_x = tuple_size(elem(@keypad1, 0)) - 1

    case coordinates do
      {x, y} -> case dir do
        "U" when y < max_y -> {x, y+1}
        "D" when y > 0 -> {x, y-1}
        "R" when x < max_x -> {x+1, y}
        "L" when x > 0 -> {x-1, y}
        _ -> {x, y}
      end
    end
  end

  def line_move(movements, {initialpos, keypositions}) do
    newpos = movements
      |> List.foldl(initialpos, &move/2)
    {newpos, keypositions ++ [newpos]}
  end

  def key_for({x,y}) do
    elem(elem(@keypad1, y),x)
  end

  def read_file_part1 do
    File.read!(@part1_file)
      |> String.split("\n")
      |> Enum.map(&String.trim/1)
      |> Enum.filter(fn line -> line != "" end)
      |> Enum.map(&String.graphemes/1)
  end

  def part1() do
    read_file_part1
      |> List.foldl({{1,1}, []}, &line_move/2)
      |> elem(1)
      |> Enum.map(&key_for/1)
  end


end

defmodule AdventOfCode.DayTwo do

  @filename "./lib/adventofcode/resource/day_two.txt"

  @keypad1 {{'','','','',''},
            {'', 1, 2, 3,''},
            {'', 4, 5, 6,''},
            {'', 7, 8, 9,''},
            {'','','','',''}}

  def move(dir, {x, y} = coordinates) do

    new = case dir do
      "U" -> {x, y-1}
      "D" -> {x, y+1}
      "R" -> {x+1, y}
      "L" -> {x-1, y}
    end

    case key_for(new) do
      key when key === '' -> coordinates
      _ -> new
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

  def read_file do
    File.read!(@filename)
      |> String.split("\n")
      |> Enum.map(&String.trim/1)
      |> Enum.filter(fn line -> line != "" end)
      |> Enum.map(&String.graphemes/1)
  end

  def part1() do
    read_file
      |> List.foldl({{1,1}, []}, &line_move/2)
      |> elem(1)
      |> Enum.map(&key_for/1)
  end


end

defmodule AdventOfCode.Day2 do

  @filename "./lib/advent_of_code/inputs/day2.txt"

  @keypad1 {{'','','','',''},
            {'', 1, 2, 3,''},
            {'', 4, 5, 6,''},
            {'', 7, 8, 9,''},
            {'','','','',''}}

  @keypad2 {{'','','','','','',''},
            {'','','', 1,'','',''},
            {'','', 2, 3, 4,'',''},
            {'', 5, 6, 7, 8, 9,''},
            {'','',"A","B","C",'',''},
            {'','','',"D",'','',''},
            {'','','','','','',''}}

  def move(dir, keypad, {x, y} = coordinates) do
    maybe_newpos = case dir do
      "U" -> {x, y-1}
      "D" -> {x, y+1}
      "R" -> {x+1, y}
      "L" -> {x-1, y}
    end
    case key_on(keypad, maybe_newpos) do
      key when key === '' -> coordinates
      _ -> maybe_newpos
    end
  end

  def line_move(movements, keypad, {initialpos, keypositions}) do
    newpos = movements
      |> List.foldl(initialpos, &move(&1, keypad, &2))
    {newpos, keypositions ++ [newpos]}
  end

  def key_on(keypad, {x,y}) do
    elem(elem(keypad, y),x)
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
      |> List.foldl({{1,1}, []}, &line_move(&1,@keypad1,&2))
      |> elem(1)
      |> Enum.map(&key_on(@keypad1, &1))
  end

  def part2() do
    read_file
      |> List.foldl({{3,1}, []}, &line_move(&1,@keypad2,&2))
      |> elem(1)
      |> Enum.map(&key_on(@keypad2, &1))
  end


end

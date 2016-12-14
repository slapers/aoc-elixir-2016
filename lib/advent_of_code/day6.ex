defmodule AdventOfCode.Day6 do

  alias AdventOfCode.Common, as: Common

  def part1() do
    Common.read_file(6)
    |> Enum.map(&String.graphemes/1)
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&reduce_highest_occurrence/1)
    |> Enum.join()
  end

  def part2() do
    Common.read_file(6)
    |> Enum.map(&String.graphemes/1)
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&reduce_lowest_occurrence/1)
    |> Enum.join()
  end

  def reduce_highest_occurrence(list) do
    reduce_sorted_occurence(list)
    |> List.first
    |> elem(0)
  end

  def reduce_lowest_occurrence(list) do
    reduce_sorted_occurence(list)
    |> List.last()
    |> elem(0)
  end

  def reduce_sorted_occurence(list) do
    Enum.reduce(list, %{}, &update_occurence/2)
    |> Map.to_list()
    |> Enum.sort(&sort_by_count/2)
  end

  def update_occurence(el, map) do
    case Map.fetch(map, el) do
      :error -> Map.put(map, el, 1)
      {:ok, num} -> Map.put(map, el, num + 1)
    end
  end

  def sort_by_count({_x,xc}, {_y,yc}), do: xc > yc
end

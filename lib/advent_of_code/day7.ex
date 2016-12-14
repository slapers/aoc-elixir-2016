defmodule AdventOfCode.Day7 do

  alias AdventOfCode.Common, as: Common

  def part1() do
    Common.read_file(7)
    |> Enum.filter(&supports_tls?/1)
    |> Enum.count()
  end

  def supports_tls?(line) do
    nets = Regex.split(~r/\[[a-z]+\]/, line)
    hypernets =
      Regex.scan(~r/\[([a-z]+)\]/, line)
      |> Enum.map(fn l -> List.last(l) end)

    (not Enum.any?(hypernets, &has_abba?/1)) and Enum.any?(nets, &has_abba?/1)
  end

  def has_abba?(string) when is_binary(string), do: has_abba?(String.graphemes(string))
  def has_abba?(graphemes) when is_list(graphemes) do
    case graphemes do
      [a,b,b,a] when a != b -> true
      [a,b,b,a | _] when a != b -> true
      [_,x,y,z | tail] -> has_abba?([x,y,z] ++ tail)
      _ -> false
    end
  end
end

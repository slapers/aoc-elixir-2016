defmodule AdventOfCode.Day7 do

  alias AdventOfCode.Common, as: Common

  def part1() do
    Common.read_file(7)
      |> Enum.filter(&supports_tls?/1)
      |> Enum.count()
  end

  def supports_tls?(line) do
    {nets, hypernets} = parse_address(line)
    (not Enum.any?(hypernets, &has_abba?/1)) and Enum.any?(nets, &has_abba?/1)
  end

  def parse_address(line) do
    nets = Regex.split(~r/\[[a-z]+\]/, line)
    hypernets =
      Regex.scan(~r/\[([a-z]+)\]/, line)
        |> Enum.map(fn l -> List.last(l) end)

    {nets, hypernets}
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

  # Part 2 starts here
  # --
  def part2() do
    Common.read_file(7)
      |> Enum.filter(&supports_ssl?/1)
      |> Enum.count
  end

  def supports_ssl?(line) do
    {nets, hypernets} = parse_address(line)
    babs = get_bab_patterns(hypernets)
    Enum.any?(nets, &has_matching_aba_for?(&1,babs))
  end

  def get_bab_patterns(nets, acc \\ []) when is_list(nets) do
    case nets do
      [net | rest] -> get_bab_patterns(rest, get_bab_patterns_in(String.graphemes(net)) ++ acc)
      [] -> acc
    end
  end

  defp get_bab_patterns_in(graphemes, acc \\ []) do
    case graphemes do
      [b,a,b] when a != b -> ([[b,a,b]] ++ acc) |> Enum.sort |> Enum.dedup
      [b,a,b | tail] when a != b -> get_bab_patterns_in([a,b] ++ tail, [[b,a,b]] ++ acc)
      [_,x,y | tail] -> get_bab_patterns_in([x,y] ++ tail, acc)
      _ -> acc
    end
  end

  def has_matching_aba_for?(string, babs) when is_binary(string) do
    graphemes = String.graphemes(string)
    babs
      |> Enum.any?(&has_matching_aba_in?(&1,graphemes))
  end

  defp has_matching_aba_in?([b,a,b], graphemes) do
    case graphemes do
      [x,y,z] when [x,y,z] == [a,b,a] -> true
      [x,y,z | _] when [x,y,z] == [a,b,a] -> true
      [_,y,z | tail] -> has_matching_aba_in?([b,a,b], [y,z] ++ tail)
      _ -> false
    end
  end
end

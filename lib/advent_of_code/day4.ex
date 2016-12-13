defmodule AdventOfCode.Day4 do

  alias AdventOfCode.Common, as: Common

  defmodule AdventOfCode.Day4.Room do
    defstruct [:name, :sector, :csum]
  end
  alias AdventOfCode.Day4.Room, as: Room

  @room_regex ~r/([a-zA-Z\-]+)(\d+)\[([a-zA-Z]+)\]/

  def calculate_hash(str) do
    String.replace(str, "-", "")
    |> String.graphemes()
    |> Enum.sort()
    |> Enum.reduce(%{}, fn (char, acc) ->
          case Map.fetch(acc, char) do
            {:ok, count} -> Map.put(acc, char, count+1)
            _ -> Map.put(acc, char, 1)
          end
        end)
    |> Map.to_list()
    |> Enum.sort(fn( {x, xc},{y, yc} ) ->
        cond do
          xc > yc -> true
          xc < yc -> false
          x < y -> true
          true -> false
        end
      end)
    |> Enum.take(5)
    |> Enum.map(fn({c,_}) -> c end)
    |> Enum.join()
  end

  def parse_room(room_str) do
    re_parts = Regex.run(@room_regex, room_str)
    case re_parts do
      [_, name, sector, csum] -> case calculate_hash(name) do
        hash when hash == csum -> %Room{name: name,
                                        sector: String.to_integer(sector),
                                        csum: csum}
        _ -> nil
      end
      _ -> nil
    end
  end

  def part1() do
    Common.read_file(4)
    |> Enum.map(&parse_room/1)
    |> Enum.filter(fn rm -> rm !== nil end)
    |> Enum.map(fn room -> room.sector end)
    |> Enum.sum()
  end

  def decryptname(name, sector) do
      alphabet = "abcdefghijklmnopqrstuvwxyz"
      shift = rem(sector, 26)
      for letter <- String.graphemes(name) do
        case :binary.match(alphabet, letter) do
          :nomatch -> " "
          {i, _} -> String.at(alphabet, rem(i + shift, 26))
        end
      end
      |> Enum.join()
  end

  def part2() do
    Common.read_file(4)
    |> Enum.map(&parse_room/1)
    |> Enum.filter(fn rm -> rm !== nil end)
    |> Enum.map(fn room -> {decryptname(room.name, room.sector), room.sector} end)
    |> Enum.filter(fn {name, sector} -> String.starts_with?(name, "northpole object") end)
    |> Enum.map(fn {_, sector} -> sector end)
    |> Enum.fetch!(0)
  end
end

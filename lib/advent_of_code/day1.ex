defmodule AdventOfCode.Day1 do

  @headings %{north: {0, 1}, east: {1, 0}, south: {0, -1}, west: {-1, 0}}

  def parse_movement(movement) do
    case String.split_at(movement,1) do
      { "R", amount } -> { :right, String.to_integer amount}
      { "L", amount } -> { :left, String.to_integer amount}
    end
  end

  def turn(to, {heading, x, y}) do
    case to do
      :right ->
        case heading do
          :north -> {:east, x, y}
          :east -> {:south, x, y}
          :south -> {:west, x, y}
          :west -> {:north, x, y}
        end
      :left ->
        case heading do
          :north -> {:west, x, y}
          :west -> {:south, x, y}
          :south -> {:east, x, y}
          :east -> {:north, x, y}
        end
    end
  end

  def move(distance, {heading, x, y}) do
    { heading,
      x + elem(@headings[heading],0) * distance,
      y + elem(@headings[heading],1) * distance }
  end

  def move_path(distance, state) do
    1..distance
    |> Enum.map(fn i -> move(i, state) end)
  end

  def update(movement, {heading, x, y}) do
    {to, distance} = parse_movement(movement)
    move(distance, turn(to, {heading, x, y}))
  end

  def update_path(movement, {heading, x, y}) do
    {to, distance} = parse_movement(movement)
    move_path(distance, turn(to, {heading, x, y}))
  end

  def part1 do
    File.read!("./lib/advent_of_code/inputs/day1.txt")
    |> String.split(", ")
    |> List.foldl({:north, 0, 0}, &update/2)
    |> fn ({_,x,y}) -> abs(x) + abs(y) end.()
  end

  def part2 do

    find_first = fn movement, {state, seen} ->

      foundAt = update_path(movement, state)
        |> Enum.reduce_while({state, seen}, fn pos, acc ->
            {_, x, y} = pos
            {_, seen} = acc
            case Map.has_key?(seen, {x,y}) do
              :true -> {:halt, abs(x) + abs(y)}
              :false -> {:cont, {pos, Map.put(seen, {x,y}, :seen)}}
            end
          end)

      case foundAt do
        blocks when is_number(blocks) -> {:halt, blocks}
        blocks -> {:cont, blocks}
      end
    end

    File.read!("./lib/advent_of_code/inputs/day1.txt")
    |> String.split(", ")
    |> Enum.reduce_while({{:north, 0, 0}, %{}}, find_first)
  end
end

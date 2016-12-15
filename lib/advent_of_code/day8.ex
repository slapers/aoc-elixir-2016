defmodule AdventOfCode.Day8 do

  alias AdventOfCode.Common, as: Common

  def part1() do
    Common.read_file(8)
    |> Enum.map(&parse_cmd/1)
    |> Enum.reduce(create_lcd(50,6), &do_command/2)
    |> draw_lcd
    |> count_lcd_pixels
  end

  def parse_cmd("rect " <> param) do
    [x,y] = String.split(param, "x")
    {:rect,String.to_integer(x),String.to_integer(y)}
  end

  def parse_cmd("rotate row y="<> param) do
    parse_rotate_cmd(:rotate_row, param)
  end

  def parse_cmd("rotate column x="<> param) do
    parse_rotate_cmd(:rotate_column, param)
  end

  def parse_rotate_cmd(cmd, param) do
    [y,by] = String.split(param, "by")
    {cmd,
      parse_cmd_int(y),
      parse_cmd_int(by)
    }
  end

  def parse_cmd_int(p), do: p |> String.trim |> String.to_integer

  def do_command({:rect, x, y}, lcd) do
    lcd
    |> Enum.with_index()
    |> Enum.map(fn({line, idx}) ->
          cond do
            idx < y -> List.duplicate(1, x) ++ Enum.drop(line, x)
            true -> line
          end
        end)
  end

  def do_command({:rotate_row, y, by} = cmd, lcd) do
    lcd
      |> Enum.with_index()
      |> Enum.map(fn {line, idx} ->
          cond do
            idx == y -> shift_line(line, by)
            true -> line
          end
      end)
  end

  def do_command({:rotate_column, x, by}, lcd) do
    transposed =
      lcd
        |> List.zip
        |> Enum.map(&Tuple.to_list/1)
    do_command({:rotate_row, x, by}, transposed)
      |> List.zip
      |> Enum.map(&Tuple.to_list/1)
  end

  def shift_line(line, by) do
    head =
      line
      |> Enum.drop(length(line)-by)
    tail =
      line
      |> Enum.take(length(line)-by)

    head ++ tail
  end

  def create_lcd(x,y) do
    for rows <- 1..y do
      List.duplicate(0, x)
    end
    |> IO.inspect
  end

  def draw_lcd(lcd) do
    lcd
      |> Enum.map(&Enum.join/1)
      |> Enum.join("\n")
      |> IO.puts
    lcd
  end

  def count_lcd_pixels(lcd) do
    lcd |> List.flatten |> Enum.sum
  end

end

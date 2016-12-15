defmodule AdventOfCodeTest.Day8 do
  use ExUnit.Case, async: true

  alias AdventOfCode.Day8, as: D8


  describe "lcd" do

    test "create_lcd creates a lcd with the specified dimensions" do
      assert [[0,0,0],[0,0,0]] == D8.create_lcd(3,2)
    end

    test "count_lcd_pixels counts enabled pixels" do
      assert 2 == D8.count_lcd_pixels([[0,1,0],[0,1,0]])
    end

  end

  describe "commands" do
    test "rect" do
      cmd = {:rect, 2, 2}
      lcd = D8.create_lcd(3,2)
      assert [[1,1,0],[1,1,0]] == D8.do_command(cmd, lcd)
    end

    test "rotate_row" do
      cmd = {:rotate_row, 0, 1}
      lcd = D8.create_lcd(3,2)
      assert [[1,0,1],
              [1,1,0]] == D8.do_command(cmd, [[0,1,1],
                                              [1,1,0]])
    end

    test "rotate_column" do
      cmd = {:rotate_column, 1, 3}
      lcd = D8.create_lcd(3,2)
      assert [[0,0,1],
              [1,1,1],
              [1,1,1],
              [1,1,0]] == D8.do_command(cmd, [[0,1,1],
                                              [1,0,1],
                                              [1,1,1],
                                              [1,1,0]])
    end

  end


  test "part1" do
    D8.part1() |> IO.inspect
  end

end

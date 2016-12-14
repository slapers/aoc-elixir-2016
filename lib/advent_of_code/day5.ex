defmodule AdventOfCode.Day5 do

  def hash(input), do: hash(input, 1)
  def hash(input, counter) do
    res = :crypto.hash(:md5, "#{input}#{counter}")
    |> Base.encode16(case: :lower)

    case String.split_at(res, 5) do
      {"00000", remainder} -> {String.at(remainder, 0), counter}
      _ -> hash(input, counter + 1)
    end
  end

  def create_password(input), do: create_password(input, "", 1)
  def create_password(input, password, counter) do
    {letter, new_counter} = hash(input, counter)
    case String.length(password) do
      size when size >= 7 -> password <> letter
      size when size < 7 -> create_password(input, password <> letter, new_counter + 1)
    end
  end

end

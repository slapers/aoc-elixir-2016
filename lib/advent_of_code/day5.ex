defmodule AdventOfCode.Day5 do

  def hash(input), do: hash(input, 1)
  defp hash(input, counter) do
    res = :crypto.hash(:md5, "#{input}#{counter}")
    |> Base.encode16(case: :lower)

    case String.split_at(res, 5) do
      {"00000", remainder} -> {remainder, counter}
      _ -> hash(input, counter + 1)
    end
  end

  def create_password(input), do: create_password(input, "", 1)
  def create_password(input, password, counter) do
    {letters, new_counter} = hash(input, counter)
    letter = String.at(letters,0)
    case String.length(password) do
      size when size >= 7 -> password <> letter
      size when size < 7 -> create_password(input, password <> letter, new_counter + 1)
    end
  end

  def create_password_p2(input), do: create_password_p2(input, "********", 1)
  defp create_password_p2(input, password, counter) do
    {letters, new_counter} = hash(input, counter)
    {pos, letter} = {String.at(letters,0), String.at(letters,1)}
    new_pass = update_password_p2(password, Integer.parse(pos), letter)
    case is_password_found?(new_pass) do
      true -> new_pass
      _ -> create_password_p2(input, new_pass, new_counter+1)
    end
  end

  defp update_password_p2(password, :error, _letter), do: password
  defp update_password_p2(password, {pos, _}, letter) do
    graphemes = String.graphemes(password)
    case String.at(password, pos) do
      "*" -> update_password_p2(graphemes, pos, letter)
      _ -> password
    end
  end
  defp update_password_p2(graphemes, pos, letter) when is_list(graphemes) do
    Enum.join(
      Enum.take(graphemes,pos) ++ [letter] ++ Enum.drop(graphemes,pos+1)
    )
  end

  def is_password_found?(pass) do
    IO.inspect(pass)
    String.graphemes(pass)
    |> Enum.filter(&(&1=="*"))
    |> Enum.count() == 0
  end
end

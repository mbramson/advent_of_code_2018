defmodule Day1 do

  def sum_lines() do
    load_file_stream()
    |> Stream.map(fn string -> Integer.parse(string) |> elem(0) end)
    |> Enum.reduce(0, fn value, acc -> value + acc end)
  end

  defp load_file_stream() do
    File.stream!("./lib/data/day_1.txt")
  end
end

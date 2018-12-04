defmodule Day1 do

  def sum_lines() do
    frequency_change_list_stream()
    |> Enum.sum
  end

  def first_frequency_hit_twice() do
    frequency_change_list_stream()
    |> Stream.cycle
    |> Enum.reduce_while({0, %MapSet{}}, fn change, {frequency, set} ->
      new_frequency = frequency + change
      if new_frequency in set do
        {:halt, new_frequency}
      else
        {:cont, {new_frequency, MapSet.put(set, new_frequency)}}
      end
    end)
  end

  defp frequency_change_list_stream() do
    load_file_stream()
    |> Stream.map(fn string -> Integer.parse(string) |> elem(0) end)
  end

  defp load_file() do
    File.read("./lib/data/day_1.txt")
  end

  defp load_file_stream() do
    File.stream!("./lib/data/day_1.txt")
  end
end

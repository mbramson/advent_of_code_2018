defmodule Day2 do
  def checksum_from_file() do
    load_file_stream()
    |> checksum()
  end

  def checksum(string_id_list) do
    string_id_list
    |> Enum.map(&generate_boolean_two_tuple_of_counts_for/1)
    |> sum_tuple_trues
    |> multiply_twos_and_threes
  end

  def generate_boolean_two_tuple_of_counts_for(string) do
    String.codepoints(string)
    |> generate_letter_counts
    |> generate_repeat_presence_tuple
  end

  @doc """
  Accepts a list of two-tuples containing boolean values. Returns a two-tuple
  where each element is the number of two-tuples in the given list whose
  corresponding element index is `true`.
  """
  def sum_tuple_trues(tuples) do
    sum_tuple_trues(tuples, {0, 0})
  end
  defp sum_tuple_trues([], acc), do: acc
  defp sum_tuple_trues([{true, true} | rest], {twos, threes}) do
    sum_tuple_trues(rest, {twos + 1, threes + 1})
  end
  defp sum_tuple_trues([{false, true} | rest], {twos, threes}) do
    sum_tuple_trues(rest, {twos, threes + 1})
  end
  defp sum_tuple_trues([{true, false} | rest], {twos, threes}) do
    sum_tuple_trues(rest, {twos + 1, threes})
  end
  defp sum_tuple_trues([_ | rest], acc), do: sum_tuple_trues(rest, acc)

  defp multiply_twos_and_threes({twos, threes}), do: twos * threes

  defp generate_letter_counts(letters) do
    Enum.reduce(letters, %{}, fn letter, acc ->
      case acc do
        %{^letter => count} -> Map.put(acc, letter, count + 1)
        %{} -> Map.put(acc, letter, 1)
      end
    end)
  end

  @doc """
  Given a string, returns a 2-tuple of booleans where the first element is true
  if the string has any letters which repeat exactly twice (and false
  otherwise). The second element is true if the string has any letters which
  repeat exactly three times (and false otherwise).
  """
  def generate_repeat_presence_tuple(letter_counts) do
    # First value true if any letter seen twice
    # Second value true if any letter seen three times
    initial_accumulator = {false, false}

    letter_counts
    |> Enum.map(&(&1))
    |> generate_repeat_presence_tuple(initial_accumulator)
  end
  defp generate_repeat_presence_tuple(letter_counts, {true, true} = acc), do: acc
  defp generate_repeat_presence_tuple([], acc), do: acc
  defp generate_repeat_presence_tuple([{_, 2} | rest], {_, three_present}) do
    generate_repeat_presence_tuple(rest, {true, three_present})
  end
  defp generate_repeat_presence_tuple([{_, 3} | rest], {two_present, _}) do
    generate_repeat_presence_tuple(rest, {two_present, true})
  end
  defp generate_repeat_presence_tuple([_ | rest], acc) do
    generate_repeat_presence_tuple(rest, acc)
  end

  defp load_file_stream() do
    File.stream!("./lib/data/day_2.txt")
  end
end

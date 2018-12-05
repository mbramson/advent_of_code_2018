defmodule Day2Test do
  use ExUnit.Case, async: true

  describe "checksum/1" do
    test "single element list with no 2 or 3 repeats returns 0" do
      assert Day2.checksum(["abc"]) == 0
    end

    test "single element list with 2 and 3 repeats returns 1" do
      assert Day2.checksum(["aabbb"]) == 1
    end

    test "two element list with 2 and 3 repeats returns 4" do
      assert Day2.checksum(["aabbb", "cccdd"]) == 4
    end
  end

  describe "generate_boolean_two_tuple_of_counts_for/1" do
    test "a returns false for both" do
      assert Day2.generate_boolean_two_tuple_of_counts_for("a") == {false, false}
    end

    test "aa returns true for 2" do
      assert Day2.generate_boolean_two_tuple_of_counts_for("aa") == {true, false}
    end

    test "aaa returns true for 3" do
      assert Day2.generate_boolean_two_tuple_of_counts_for("aaa") == {false, true}
    end

    test "ababa returns true for both" do
      assert Day2.generate_boolean_two_tuple_of_counts_for("ababa") == {true, true}
    end

    test "aaabbbccc returns true for 3" do
      assert Day2.generate_boolean_two_tuple_of_counts_for("aaabbbccc") == {false, true}
    end

    test "aaaa returns false for both" do
      assert Day2.generate_boolean_two_tuple_of_counts_for("aaaa") == {false ,false}
    end

    test "empty string returns false for both" do
      assert Day2.generate_boolean_two_tuple_of_counts_for("") == {false, false}
    end
  end
end

defmodule AdventOfCode.Day16Test do
  use ExUnit.Case

  import AdventOfCode.Day16

  test "part1" do
    input = "C0015000016115A2E0802F182340"
    result = part1(input)

    assert result == 23
  end

  test "part2" do
    input = "CE00C43D881120"
    result = part2(input)

    assert result == 9
  end
end

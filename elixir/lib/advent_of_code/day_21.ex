defmodule AdventOfCode.Day21 do

  def parse(inp) do
    inp
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn s -> s |> String.split(": ") |> Enum.at(1) |> String.to_integer() end)
  end

  def deterministic_dice do
    # 100-sided die value stream as 1 to 100
    die = Stream.cycle(1..100)
    Stream.zip([
      die
      |> Stream.take_every(3),
      die
      |> Stream.drop(1)
      |> Stream.take_every(3),
      die
      |> Stream.drop(2)
      |> Stream.take_every(3)
    ])
    |> Stream.map(&Tuple.sum/1)
    |> Stream.with_index()
  end

  def part1(args) do
    [pos1, pos2] = args
                   |> parse()

    Enum.reduce_while(deterministic_dice(), {{pos1, 0}, {pos2, 0}}, fn
      {_, turn}, {{_, s1}, {_, s2}} when s1 > 999 or s2 > 999 ->
        {:halt, {turn * 3, min(s1, s2)}}

      {roll_value, turn}, {{p1, s1}, {p2, s2}} ->
        p1? = rem(turn, 2) == 0

        if p1? do
          p1 = roll_position(p1, roll_value)
          {:cont, {{p1, s1 + p1}, {p2, s2}}}
        else
          p2 = roll_position(p2, roll_value)
          {:cont, {{p1, s1}, {p2, s2 + p2}}}
        end
    end)
    |> Tuple.product()
  end

  # win condition
  def turn({_, _, _}, {id, _, s}) when s >= 21 do
    # add a win to the respective player
    if id == 0, do: {1, 0}, else: {0, 1}
  end

  # rec case
  def turn({id, p, s}, player2) do
    wins =
      # loop through all combinations and calculate recursively who wins for each choice
      for roll_value <- driac_dice() do
        p = roll_position(p, roll_value)
        memoized_turn(&AdventOfCode.Day21.turn/2, player2, {id, p, s + p})
      end
    # count wins
    Enum.reduce(wins, {0, 0}, fn {w1, w2}, {e1, e2} -> {e1 + w1, e2 + w2} end)
  end

  def memoized_turn(func, key1, key2) do
    case Process.get({key1, key2}) do
      nil ->
        res = func.(key1, key2)
        Process.put({key1, key2}, res)
        res
      val ->
        val
    end
  end

  # combinations
  def driac_dice() do
    for i <- 1..3, j <- 1..3, k <- 1..3, do: i + j + k
  end

  def roll_position(p, roll_value), do: rem(p + roll_value - 1, 10) + 1

  def part2(args) do
    [pos1, pos2] = args
                   |> parse()

    # count the number of winning paths for either recursively
    {w1, w2} = turn({0, pos1, 0}, {1, pos2, 0})
    max(w1, w2)
  end
end

defmodule AdventOfCode.Day01 do
  
  def part1(args) do
    String.split(args)
    |> Enum.map(fn n -> String.to_integer(n) end)
    |> Enum.reduce(%{prev: nil, x: 0},
      fn curr, %{prev: prev, x: x} ->
        if is_number(prev) and curr > prev do
          %{prev: curr, x: x+1}
        else
          %{prev: curr, x: x}
        end
      end)
    |> Map.get(:x)

  end

  def part2(_args) do
  end
end

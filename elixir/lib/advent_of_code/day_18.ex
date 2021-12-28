defmodule AdventOfCode.Day18 do
  def parse(inp) do
    inp
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn s -> s |> Code.eval_string([], __ENV__) |> elem(0) end)
  end

  def reduce(num) do
    {exploded, num, _, _} = explode(num, 0)
    if exploded do
      # reduce until we no longer explode
      reduce(num)
    else
      # try to split
      {splt, num} = split(num)

      if splt do
        # repeat
        reduce(num)
      else
        # reducing done
        num
      end
    end
  end

  # try to find the leftmost 4x nested number and then return
  # {true, sub-expr to replace with, left increase, right increase}
  
  # depth 4 found, explode
  # depth > 4 can't happen, because after adding two reduced numbers we can get depth 4 max
  def explode([l, r], 4), do: {true, 0, l, r}
  # depth less than 4
  def explode(num, _) when is_number(num), do: {false, num, 0, 0}

  def explode([l, r], d) do
    # search left first
    {exploded, num, l_inc, r_inc} = explode(l, d+1)

    #IO.write("num: ")
    #IO.inspect([l, r])

    if exploded do
      #IO.puts("left side did explode")
      #exit(:shutdown)
      # add to the right side
      {true, [num, right_add(r, r_inc)], l_inc, 0}
    else
      {exploded, num, l_inc, r_inc} = explode(r, d+1)
      if exploded do
        #IO.puts("right side did explode")
        # add to the left side
        {true, [left_add(l, l_inc), num], 0, r_inc}
      else
        #IO.puts("right side didn't explode")
        {false, [l, r], l_inc, r_inc}
      end
    end
  end

  # add to_add to the immediately left number
  def left_add([l, r], to_add), do: [l, left_add(r, to_add)]
  def left_add(num, to_add) when is_number(num), do: num + to_add

  # add to_add to the immediately right number
  def right_add([l, r], to_add), do: [right_add(l, to_add), r]
  def right_add(num, to_add) when is_number(num), do: num + to_add

  # recursively try to split
  def split([l, r]) do
    {splt, l} = split(l)
    if splt do
      {true, [l, r]}
    else
      {splt, r} = split(r)
      if splt do
        {true, [l, r]}
      else
        {false, [l, r]}
      end
    end
  end
  

  # {did it split, replace with subexpr}
  def split(num) when num < 10, do: {false, num}
  def split(num), do: {true, [floor(num/2), ceil(num/2)]}

  def magnitude([l, r]), do: 3*magnitude(l) + 2*magnitude(r)
  def magnitude(num), do: num

  def part1(args) do
    args
    |> parse()
    |> Enum.reduce([],
      fn num, acc ->
        if acc == [] do
          num
        else
          reduce([acc, num])
        end
      end
    )
    |> magnitude()

  end

  def comb(nums) do
    for a <- nums, b <- nums, a != b do
      # add a and b
      reduce([a, b]) |> magnitude()
    end
  end

  def part2(args) do
    args
    |> parse()
    |> comb()
    |> Enum.max()
  end
end

defmodule AdventOfCode.Day20 do
  def parse(inp) do
    [rules, img] = inp
    |> String.trim()
    |> String.split("\n\n")

    # switch between two keys in a map because we alternate
    # between all lit and all unlit in the infinite graph
    # and we only track the non infinite quantity
    {parse_rules(rules), %{default: false, others: parse_img(img)}}
  end

  def parse_img(img) do
    img
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.flat_map(fn {str, y} ->
      str
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.filter(fn {c, _} -> c == "#" end)
      |> Enum.map(fn {_, x} -> {x, y} end)
    end)
    |> MapSet.new()
  end

  def parse_rules(str) do
    str
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.filter(fn {c, _} -> c == "#" end)
    |> MapSet.new(&elem(&1, 1))
  end

  def iter({rules, img}, n) do
    img
    |> Stream.iterate(&enhance(&1, rules))
    |> Stream.take(n + 1)
    |> Enum.to_list()
    |> List.last()
    |> Map.get(:others)
    |> MapSet.size()
  end

  def enhance(img = %{default: prev_default, others: set}, rules) do
    # switch
    new_default = if(prev_default, do: 511 in rules, else: 0 in rules)

    set
    # get the whole space of possible actions
    |> candidates()
    # game of life iteration on every coord of these candidates
    |> Enum.map(&{&1, enhance_coord(&1, img, rules)})
    # only take those that are on/off (depending on the iteration)
    |> Enum.filter(&(elem(&1, 1) != new_default))
    |> MapSet.new(&elem(&1, 0))
    # swaperoo
    |> then(&%{default: new_default, others: &1})
  end

  def candidates(set), do: set |> Enum.flat_map(&neighbors/1) |> MapSet.new()

  def enhance_coord(c, img, rules), do: c |> coord_to_idx(img) |> then(&(&1 in rules))

  def coord_to_idx(c, %{default: d, others: set}) do
    c
    |> neighbors()
    |> Enum.map(&if(&1 in set, do: not d, else: d))
    |> Enum.map(&if(&1, do: 1, else: 0))
    |> Integer.undigits(2)
  end

  def neighbors({x, y}), do: for y <- y-1..y+1, x <- x-1..x+1, do: {x, y}

  def part1(args) do
    args
    |> parse()
    |> iter(2)
  end

  def part2(args) do
    args
    |> parse()
    |> iter(50)
  end
end

defmodule AdventOfCode.Day14 do
  def parse(inp) do
    [polymer_template, rules] = inp
                       |> String.trim()
                       |> String.split("\n\n")

    # %{["C", "B"] => 1, ["N", "C"] => 1, ["N", "N"] => 1}
    pair_count = polymer_template
            |> String.graphemes()
            |> Enum.chunk_every(2, 1, :discard)
            |> Enum.frequencies()

    # %{"CH" => "B", ...}
    rule_map = rules
               |> String.split("\n")
               |> Enum.map(&(String.split(&1, " -> ") |> List.to_tuple()))
               |> Enum.into(%{})

    {pair_count, polymer_template, rule_map}
  end

  # polymer = the current pairs of chars in the current state of the polymer
  # counts = counts of each char in the current state of the polymer
  # rules = map of pair insertion rules
  # step = iteration counter
  def pair_insert({polymer, counts}, rules, step) when step > 0 do
    # IO.inspect(binding())

    polymer
    |> Map.to_list()
    |> Enum.reduce({%{}, counts},
      fn {[first, second], count}, {map, counts} ->
        if Map.has_key?(rules, first <> second) do
          middle = Map.get(rules, first <> second)
          counts = Map.update(counts, middle, count, &(&1 + count))

          # AB -> C means AC and BC, as many AC/BC as there were AB
          map = Map.update(map, [first, middle], count, &(&1 + count))
                |> Map.update([middle, second], count, &(&1 + count))
          {map, counts} 
        else
          {map, counts} 
        end
      end
    )
    |> pair_insert(rules, step - 1)
  end

  # finished all steps
  def pair_insert({_, counts}, _, 0), do: counts

  def solve(args, steps) do
    {pair_count, polymer_template, rule_map} = args
                                      |> parse()

    # count of every letter in a map
    pair_insert({pair_count, polymer_template 
                             |> String.graphemes()
                             |> Enum.frequencies()},
                rule_map, steps)
    |> Map.values()
    |> Enum.min_max()
    |> then(fn {min, max} -> max - min end)
  end

  def part1(args) do
    args
    |> solve(10)
  end

  def part2(args) do
    args
    |> solve(40)
  end
end

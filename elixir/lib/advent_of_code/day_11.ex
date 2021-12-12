defmodule AdventOfCode.Day11 do
  require IEx;
  
  def increment_all(energy_map) do
    energy_map
    |> Enum.map(fn {{x, y}, energy} -> {{x, y}, energy + 1} end)
    |> Map.new()
  end

  def flash_all(energy_map) do
    #debug(energy_map)

    to_flash = energy_map
             |> Enum.filter(fn {_, energy} -> energy != :flashed and energy > 9 end)
             |> Enum.map(&elem(&1, 0))

    #IO.inspect(to_flash)

    # flash specific octopuses
    energy_map = Enum.reduce(to_flash, energy_map, &AdventOfCode.Day11.flash/2)

    # repeat until we have don't have any flashing ones left that haven't already flashed
    if length(to_flash) == 0, do: energy_map, else: flash_all(energy_map)
  end

  def flash(octopus, energy_map) do
    energy_map = energy_map
                 |> Map.put(octopus, :flashed)

    octopus
    |> AdventOfCode.Day11.neighbors()
    |> Enum.reduce(energy_map, &AdventOfCode.Day11.increment/2)
  end

  def around(x), do: max(0,x-1)..min(9,x+1)
  def neighbors({x, y}), do: for nx <- around(x), ny <- around(y), do: {nx, ny}

  # incr octopus
  def increment(octopus, energy_map) when is_map_key(energy_map, octopus) do
    %{energy_map | octopus => increment(energy_map[octopus])}
  end

  # no octopus to increment
  def increment(_, energy_map), do: energy_map

  def increment(:flashed), do: :flashed
  def increment(energy), do: energy + 1

  def step(energy_map) do
    #IEx.pry

    energy_map
    #|> debug()
    |> AdventOfCode.Day11.increment_all()
    #|> debug()
    |> AdventOfCode.Day11.flash_all()
    #|> debug()
    |> Enum.map(
      fn {octopus, energy} -> 
        if energy > 9 do
          {octopus, 0}
        else
          {octopus, energy}
        end
      end)
    |> Map.new()
    #|> debug()
    
end

  def parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.to_charlist/1)
    |> Enum.map(fn line -> Enum.map(line, fn c -> c-?0 end) end)
    |> Enum.with_index()
    # from matrix to (x,y) => energy level for each entry/octopus
    |> Enum.reduce(%{}, 
      fn {row, y}, acc ->
        row
        |> Enum.with_index()
        |> Enum.reduce(%{}, 
          fn {energy, x}, rowacc ->
            Map.put(rowacc, {x, y}, energy)
          end)
        |> Map.merge(acc)
      end)
  end

  def debug(energy_map) do
    for i <- 0..9 do
      for j <- 0..9 do
        if is_number(energy_map[{j, i}]) do
          IO.write(energy_map[{j, i}])
        else
          IO.write("0")
        end
      end
      IO.write("\n")
    end
    IO.write("\n")
    energy_map
  end

  def part1(args) do
    args
    |> parse()
    |> Stream.iterate(&AdventOfCode.Day11.step/1)
    |> Stream.map(&Enum.count(&1, fn {_, energy} -> energy == 0 end))
    |> Stream.take(101)
    |> Enum.sum()
  end

  def part2(args) do
    args
    |> parse()
    |> Stream.iterate(&AdventOfCode.Day11.step/1)
    |> Stream.map(&Enum.all?(&1, fn {_, energy} -> energy == 0 end))
    |> Stream.take_while(&not/1)
    |> Enum.to_list()
    |> length()
  end
end

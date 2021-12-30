defmodule AdventOfCode.Day25 do

  @w 139
  @h 137

  def parse(inp) do
    inp
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.graphemes/1)
    |> Stream.with_index()
    |> Enum.flat_map(
      fn {c, i} ->
        c
        |> Stream.with_index()
        # for every char, {{i, j}, char}
        |> Enum.map(&({{i, elem(&1, 1)}, elem(&1, 0)}))
      end
    )
    |> Map.new()
  end

  def iter(map, count \\ 1) do
    right = move(map, 1, 0, ">")
    down = move(right, 0, 1, "v")
    
    if down == map do
      # no change, end
      count
    else
      iter(down, count + 1)
    end
  end

  # move char c in map map by dx dy
  def move(map, dx, dy, c) do
    for y <- 0..@h-1, x <- 0..@w-1, into: %{} do
      # iterate over all cells
      new_char =
        (if map[{y,x}] == "." do
          # cell is empty, does a cucumber move into here or nah?
          # (in the case of a wrap around)
          px = rem(x + @w - dx, @w)
          py = rem(y + @h - dy, @h)
          if map[{py, px}] == c, do: c, else: "."
        else
          if map[{y,x}] == c do
            # we are on a cell that might move
            nx = rem(x + dx, @w)
            ny = rem(y + dy, @h)
            if map[{ny,nx}] == ".", do: ".", else: c
          else
            map[{y,x}]
          end
        end)

      {{y,x},new_char}
    end
  end

  def dbg(map) do
    for y <- 0..@h-1 do
      for x <- 0..@w-1 do
        IO.write(map[{y,x}])
      end
      IO.puts("")
    end
    IO.puts("")
    map
  end

  def part1(args) do
    args
    |> parse()
    #|> dbg()
    |> iter()
  end

  def part2(args) do
    args
  end
end

defmodule AdventOfCode.Day13 do
  require IEx;

  def parseDots(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.filter(fn s -> String.contains?(s, ",") end)
    |> Enum.map(
      fn s ->
        s 
        |> String.split(",")
        |> Enum.map(&String.to_integer/1)
      end
    )
    #|> IO.inspect(charlists: :as_lists)
  end

  def parseFold(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.filter(fn s -> String.contains?(s, "fold") end)
    |> Enum.map(
      fn s ->
        s
        |> String.split(" ")
        |> Enum.at(2)
        |> String.split("=")
      end
    )
  end

  def fold([fold_axis | fold_coord], dots) do
    fold_coord = fold_coord
                 |> Enum.at(0)
                 |> String.to_integer()

    dots
    |> Enum.filter(fn [x, y] -> (fold_axis == "y" and y != fold_coord) or (fold_axis == "x" and x != fold_coord) end)
    |> Enum.map(
      fn [x, y] ->
        flipped_y = fold_coord - (y - fold_coord)
        flipped_x = fold_coord - (x - fold_coord)
        if fold_axis == "y" do
          if y < fold_coord, do: [x, y], else: [x, flipped_y]
        else
          if x < fold_coord, do: [x, y], else: [flipped_x, y]
        end
      end
    )
    |> Enum.uniq()
  end

  def part1(args) do
    dots = args
           |> parseDots()

    args
    |> parseFold()
    |> Enum.at(0)
    |> fold(dots)
    |> length()
  end

  def debug(dots) do
    for i <- 0..5 do
      for j <- 0..38 do
        if Enum.member?(dots, [j, i]) do
          IO.write("#")
        else
          IO.write(" ")
        end
      end
      IO.write("\n")
    end
    :ok
  end

  def part2(args) do
    dots = args
           |> parseDots()

    dots = args
           |> parseFold()
           |> Enum.reduce(dots, fn fold_data, dots -> fold(fold_data, dots) end)
    
    debug(dots)
  end
end

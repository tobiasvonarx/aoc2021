defmodule AdventOfCode.Day22 do
  require IEx;

  def parse(inp) do
    inp
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(
      fn s ->
        n = s
        |> String.split(["on x=","off x=","..",",y=",",z="])
        |> Enum.drop(1)
        |> Enum.map(&String.to_integer/1)
        |> then(
          fn [x1,x2,y1,y2,z1,z2] ->
            # shift by one for vol
            [x1,x2+1,y1,y2+1,z1,z2+1]
          end
        )

        {s |> String.split(" ") |> Enum.at(0), n}
      end
    )
  end

  def expand([x1,x2,y1,y2,z1,z2]), do: for x<-x1..x2, y<-y1..y2, z<-z1..z2, do: {x,y,z}

  def crop([mn, mx | tail], [bn, bx | bt]) when mn >= bx or mx <= bn, do: [0, 0 | crop(tail, bt)]
  def crop([mn, mx | tail], [bn, bx | bt]), do: [max(mn, bn), min(mx, bx) | crop(tail, bt)]
  def crop(_,_), do: []

  def subtract({dims, lst}, range) do
    cropped_range = crop(range, dims)
    [x1,x2,y1,y2,z1,z2] = cropped_range
    if x2 <= x1 or y2 <= y1 or z2 <= z1 do
      {dims, lst}
    else
      {dims, [{cropped_range, []} | subtract(lst, cropped_range)]}
    end
  end

  def subtract(boxes, range) do
    boxes
    |> Enum.map(&subtract(&1, range))
    |> Enum.reject(&volume(&1) == 0)
  end

  def volume({dims, lst}), do: volume(dims) - Enum.sum(Enum.map(lst, &volume/1))
  def volume([x1, x2, y1, y2, z1, z2]), do: (x2-x1)*(y2-y1)*(z2-z1)

  def part1(args) do
    args
    |> parse()
    #|> IO.inspect(charlists: :as_lists)
    |> Enum.reduce([],
      fn {on, ranges}, boxes ->
        # shift everything because a 1x1x1 box has volume 1 and not volume 0
        ranges = crop(ranges,[-50,51,-50,51,-50,51]) #|> IO.inspect(charlists: :as_lists)

        boxes = boxes |> Enum.map(&subtract(&1, ranges))

        if on == "on" do
          [{ranges, []} | boxes]
        else
          boxes
        end
      end
    )
    |> Enum.map(&volume/1)
    |> Enum.sum()
  end

  def part2(args) do
    args
    |> parse()
    |> Enum.reduce([],
      fn {on, ranges}, boxes ->
        # no need to crop
        boxes = boxes |> Enum.map(&subtract(&1,ranges))
        if on == "on" do
          [{ranges, []} | boxes]
        else
          boxes
        end
      end
    )
    |> Enum.map(&volume/1)
    |> Enum.sum()
  end
end

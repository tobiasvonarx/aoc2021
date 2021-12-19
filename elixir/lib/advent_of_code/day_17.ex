defmodule AdventOfCode.Day17 do
  def parse(inp) do
    [_ | tail] = inp 
    |> String.trim()
    |> String.split(["target area: x=",", y=", ".."])
    
    tail
    |> Enum.map(&String.to_integer/1)

  end

  # see if yvel + yvel-1 + yvel-2 + yvel-x ends up between miny and maxy for any x
  def verify_vel(_, y, ymin, ymax) when ymin <= y and y <= ymax, do: true
  def verify_vel(_, y, ymin, ymax) when (y > ymax and ymax > 0) or (ymin < 0 and y < ymin), do: false
  def verify_vel(vel, y, ymin, ymax), do: verify_vel(vel-1, y+vel, ymin, ymax)

  # maximize velocity to get the highest y pos
  def maximize_vel([_,_,ymin,ymax]) do
    lim = max(abs(ymin), abs(ymax))
    max_vel = Enum.find(lim..-lim, fn vel -> verify_vel(vel, 0, ymin, ymax) end)

    # highest y pos of vel v is
    # vel + vel-1 + vel-2 + .. + 2 +  1
    div(max_vel * (max_vel+1), 2)
  end

  def part1(args) do
    args
    |> parse()
    |> maximize_vel()
  end

  def simulate(_, _, x, y, _, xmax, ymin, ymax) when x > xmax or (y > ymax and ymax > 0) or (ymin < 0 and y < ymin), do: 0
  def simulate(_, _, x, y, xmin, xmax, ymin, ymax) when (xmin <= x and x <= xmax) and (ymin <= y and y <= ymax), do: 1
  def simulate(velx, vely, x, y, xmin, xmax, ymin, ymax) do
    simulate(velx - (if(velx > 0, do: 1, else: if(velx < 0, do: -1, else: 0))), vely-1, x+velx, y+vely, xmin, xmax, ymin, ymax)
  end

  def count([xmin, xmax, ymin, ymax]) do
    rx = 1..xmax+1
    limy = max(abs(ymin), abs(ymax))
    ry = limy..-limy

    rx
    |> Enum.reduce(0,
      fn x, s ->
        ry
        |> Enum.reduce(s,
          fn y, ss ->
            ss + simulate(x,y,0,0,xmin,xmax,ymin,ymax)
          end
        )
      end
    )
  end


  def part2(args) do
    args
    |> parse()
    |> count()
  end
end

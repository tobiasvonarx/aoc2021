defmodule AdventOfCode.Day15 do

  @p1dim 9
  @p2dim 499
  

  def parse(inp) do
    inp
    |> Enum.with_index()
    |> Enum.flat_map(
      fn {row, i} ->
        row 
        |> String.to_charlist()
        |> Enum.with_index()
        |> Enum.flat_map(
          fn {cell, j} ->
            #{[j, i], cell-?0}
            cond do
              i==0 && j==0 -> [[[j+1, i], [j, i], cell-?0], [[j, i+1], [j, i], cell-?0]]
              
              i==0 && j==@p2dim ->  [[[j-1, i], [j, i], cell-?0], [[j, i+1], [j, i], cell-?0]]
              i==0 -> [[[j-1, i], [j, i], cell-?0], [[j+1, i], [j, i], cell-?0], [[j, i+1], [j, i], cell-?0]]

              j==0 && i==@p2dim -> [[[j-1, i], [j, i], cell-?0], [[j, i-1], [j, i], cell-?0], [[j+1, i], [j, i], cell-?0], [[j, i+1], [j, i], cell-?0]]
              j==0 -> [[[j, i-1], [j, i], cell-?0], [[j+1, i], [j, i], cell-?0], [[j, i+1], [j, i], cell-?0]]

              i==@p2dim && j==@p2dim ->[[[j-1, i], [j, i], cell-?0], [[j, i-1], [j, i], cell-?0]]
              i==@p2dim -> [[[j-1, i], [j, i], cell-?0], [[j, i-1], [j, i], cell-?0], [[j+1, i], [j, i], cell-?0]]
              j==@p2dim -> [[[j-1, i], [j, i], cell-?0], [[j, i-1], [j, i], cell-?0], [[j, i+1], [j, i], cell-?0]]
            
              true -> [[[j-1, i], [j, i], cell-?0], [[j, i-1], [j, i], cell-?0], [[j+1, i], [j, i], cell-?0], [[j, i+1], [j, i], cell-?0]]
            end
          end
        )
      end
    )
    #|> IO.inspect(charlists: :as_lists)
  end

  def get_risk(risk_vertices, inp) do
    inp
    |> Enum.with_index()
    |> Enum.reduce(0, 
      fn {row, i}, total_risk ->
        row
        |> String.to_charlist()
        |> Enum.with_index()
        |> Enum.reduce(0,
          fn {cell, j}, sum ->
            if Enum.member?(risk_vertices, [j, i]) do
              sum + cell-?0
            else
              sum
            end
          end
        )
        |> then(fn sum -> total_risk + sum end)
      end
    )
        
  end

  def part1(args) do
    g = Graph.new()

    args = args
    |> String.trim()
    |> String.split("\n")
    
    res = args
    |> parse()
    |> Enum.reduce(g,
      fn [from, to, cost], graph ->
        e = Graph.Edge.new(from, to, weight: cost)
        Graph.add_edge(graph, e)
      end
    )
    #|> Graph.info()
    |> Graph.dijkstra([0,0], [(@p1dim+1)*(@p1dim+1)-1,(@p1dim+1)*(@p1dim+1)-1])
    |> get_risk(args)

    res - (args |> Enum.at(0) |> String.at(0) |> String.to_integer())
  end

  def preprocess(orig) do
    wider = orig
    |> String.trim()
    |> String.split("\n")
    # fill horizontal
    |> Enum.map(fn r -> r<>incr(r,1)<>incr(r,2)<>incr(r,3)<>incr(r,4) end)
    # fill vertical
    
    wider++incr(wider,1)++incr(wider,2)++incr(wider,3)++incr(wider,4)
  end

  def incr(nums, times) when is_list(nums) do
    nums
    |> Enum.map(fn n -> AdventOfCode.Day15.incr(n, times) end)
  end

  def incr(nums, times) when times > 0 do
    nums
    |> String.to_charlist()
    |> Enum.map(fn c -> Integer.mod(c-?0, 9) + 1 + ?0 end)
    |> List.to_string()
    |> incr(times - 1)
  end

  def incr(nums, 0), do: nums

  def part2(args) do
    g = Graph.new()

    args = args
    |> preprocess()

    res = args
    |> parse()
    |> Enum.reduce(g,
      fn [from, to, cost], graph ->
          e = Graph.Edge.new(from, to, weight: cost)
          Graph.add_edge(graph, e)
      end
    )
    |> Graph.dijkstra([0,0], [@p2dim, @p2dim])
    |> IO.inspect()
    |> get_risk(args)
    
    res - (args |> Enum.at(0) |> String.at(0) |> String.to_integer())
  end
end

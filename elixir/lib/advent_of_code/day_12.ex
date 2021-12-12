defmodule AdventOfCode.Day12 do
  require IEx;

  def parse_adjacency_list(input) do
    input
    |> String.trim()
    |> String.split("\n")
    # adjacencies
    |> Enum.flat_map( 
      fn connection ->
        [from, to] = connection
                     |> String.trim()
                     |> String.split("-") 
  
        # can't move to the start or from the end
        if(from == "start", do: [{from, to}], else: if(to == "end", do: [{from, to}], else: [{from, to}, {to, from}]))
      end
    )
    # cave => list of caves it is connected to
    |> Enum.reduce(%{}, fn {from, to}, adj_list -> Map.put(adj_list, from, [to | Map.get(adj_list, from, [])]) end)
    #|> IO.inspect()
  end

  def is_small_cave(cave) do
    cc = cave
         |> String.to_charlist()
         |> Enum.at(0)
    if cc >= ?a, do: 1, else: 0
  end

  def dfs(adj, vis, path, from, max_small_cave) do
    #IEx.pry
    #IO.inspect(from)

    vis = Map.put(vis, from, Map.get(vis, from, 0) + is_small_cave(from))

    max_small_cave = if vis[from] == 2 and from != "start", do: 1, else: max_small_cave

    if from == "end" do
      # count path
      1
    else
      path = [from | path]

      # filter the caves which we are allowed to visit from our current cave
      to_visit = Enum.filter(adj[from], fn to -> (Map.get(vis, to, 0) < max_small_cave) end)

      #IO.inspect(to_visit)

      # visit each possible way to go, recursively
      Enum.map(to_visit, &dfs(adj, vis, path, &1, max_small_cave))
      |> Enum.sum()
    end
  end

  # "start" => n to init the vis count to not vis start in either case
  def dfs(adj, n), do: dfs(adj, %{"start" => n}, [], "start", n)

  def part1(args) do
    args
    |> parse_adjacency_list()
    |> dfs(1)
  end

  def part2(args) do
    args
    |> parse_adjacency_list()
    |> dfs(2)
  end
end

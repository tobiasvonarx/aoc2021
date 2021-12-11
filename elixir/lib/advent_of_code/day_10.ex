defmodule AdventOfCode.Day10 do
  
  def preprocess(raw) do
    raw
    |> String.split("\n")
    |> Enum.map(&String.to_charlist/1)
  end
  
  def check(line), do: check([], line)

  # close the most recently opened bracket
  def check([?( | stack], [?) | tail]), do: check(stack, tail)
  def check([?[ | stack], [?] | tail]), do: check(stack, tail)
  def check([?{ | stack], [?} | tail]), do: check(stack, tail)
  def check([?< | stack], [?> | tail]), do: check(stack, tail)
  # otherwise,close a bracket that is not the most recently opened bracket 
  def check(_, [char | _]) when char in [?), ?], ?}, ?>], do: %{status: :corrupted, culprit: char}

  # we open a bracket 
  def check(stack, [char | tail]) when char in [?(, ?[, ?{, ?<], do: check([char | stack], tail)

  # legal line
  def check([],[]), do: %{status: :ok, culprit: nil}

  # still some open brackets left in the stack to be matched when the line is done
  def check(stack, []), do: %{status: :incomplete, culprit: stack}
  
  @errscore %{?) => 3, ?] => 57, ?} => 1197, ?> => 25137} 

  def part1(args) do
    AdventOfCode.Day10.preprocess(args)
    |> Enum.map(&AdventOfCode.Day10.check/1)
    |> Enum.reduce(0, fn %{:status => s, :culprit => c}, acc -> if s == :corrupted, do: acc + @errscore[c], else: acc end)
  end

  # stack contains the unmatched starting brackets
  def score(stack), do: score(stack, 0)

  # accumulative nature of point count coming in handy
  def score([?( | tail], points), do: score(tail, points*5 + 1) 
  def score([?[ | tail], points), do: score(tail, points*5 + 2) 
  def score([?{ | tail], points), do: score(tail, points*5 + 3) 
  def score([?< | tail], points), do: score(tail, points*5 + 4)

  # base case
  def score([], points), do: points

  def part2(args) do
    scores = AdventOfCode.Day10.preprocess(args)
    |> Enum.map(&AdventOfCode.Day10.check/1)
    |> Enum.filter(fn %{:status => s} -> s == :incomplete end)
    |> Enum.map(fn %{:culprit => stack} -> AdventOfCode.Day10.score(stack) end)
    |> Enum.sort

    # the result is the median of the sorted score list
    Enum.at(scores, div(length(scores), 2))
  end
end

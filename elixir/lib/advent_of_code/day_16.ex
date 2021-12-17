defmodule AdventOfCode.Day16 do
  require IEx;

  def parse(inp) do
    inp
    |> String.trim()
    |> hex_to_bin()
  end

  def hex_to_bin(hex) do
    hex
    |> Base.decode16()
    |> elem(1)
  end


  # literal packet, base case
  def packet(<<v::3, t::3, r::bits>>) when t == 4 do
    literal_value(r, 0, v)
  end

  # non literal packet, 11 bits for the number of subpackets
  def packet(<<v::3, t::3, 1::1, len::11, rest::bits>>) do
    {rest, l, v_sum} = rec(rest, [], v, len)
    {rest, op(l, t), v_sum}
  end

  # non literal packet, 15 bits for the length in bits of the subpackets
  def packet(<<v::3, t::3, 0::1, len::15, nested::size(len), rest::bits>>) do
    # know the size of until where a packet's subpackets go 
    {l, v_sum} = rec(<<nested::size(len)>>, [], v)
    {rest, op(l, t), v_sum}
  end

  # blocks of 5, last block starts with 0, other blocks start with 1
  def literal_value(<<0::1, x::4, r::bits>>, res, v), do: {r, res * 16 + x, v}
  def literal_value(<<1::1, x::4, r::bits>>, res, v), do: literal_value(r, res * 16 + x, v)

  # vals = values of subpackets
  def op(vals, 0), do: Enum.sum(vals)
  def op(vals, 1), do: Enum.product(vals)
  def op(vals, 2), do: Enum.min(vals)
  def op(vals, 3), do: Enum.max(vals)
  def op(vals, 5), do: if(Enum.at(vals, 1) > Enum.at(vals, 0), do: 1, else: 0)
  def op(vals, 6), do: if(Enum.at(vals, 1) > Enum.at(vals, 0), do: 1, else: 0)
  def op(vals, 7), do: if(Enum.at(vals, 1) > Enum.at(vals, 0), do: 1, else: 0)
    

  # length of subpackets given 
  def rec(<<>>, vals, v_sum), do: {vals, v_sum}
  def rec(<<b::bits>>, vals, v_sum) do
    b
    |> packet()
    |> then(
      fn {r, val, v} ->
        # concat subpacket values and increase version number sum
        rec(r, [val | vals], v_sum + v)
      end
    )
  end

  # number of subpackets given, count down to know when we searched through all direct subpackets 
  def rec(<<b::bits>>, vals, v_sum, 0), do: {b, vals, v_sum}
  def rec(<<b::bits>>, vals, v_sum, n) when n > 0 do
    b
    |> packet()
    |> then(
      fn {r, val, v} ->
        # concat subpacket values and increase version number sum
        rec(r, [val | vals], v_sum + v, n - 1)
      end
    )
  end

  def part1(args) do
    args
    |> parse()
    |> packet()
    |> elem(2)
  end

  def part2(args) do
    args
    |> parse()
    |> packet()
    |> elem(1)
  end
end

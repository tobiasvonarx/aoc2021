defmodule AdventOfCode.Day24 do
  def part1(_args) do
"inp w        # w = n[0]
mul x 0       # x = ((z % 26) + 11) != w  
add x z
mod x 26
div z 1
add x 11
eql x w         
eql x 0
mul y 0
add y 25      # y = (25 * x) + 1
mul y x
add y 1
mul z y       # z = z * y
mul y 0       # y = (w + 6) * x
add y w
add y 6
mul y x
add z y       # z = z + y

inp w         # w = n[1]
mul x 0       # x = ((z % 26) + 11) != w
add x z 
mod x 26
div z 1
add x 11
eql x w
eql x 0
mul y 0       # y = (25 * x) + 1
add y 25
mul y x
add y 1
mul z y       # z = z * y
mul y 0       # y = (w + 12) * x
add y w
add y 12
mul y x
add z y       # z = z + y
"

# pattern =>
# w = n[i]
# x = ((z % 26) + a != w)
# z //= b
# z *= (25 * x) + 1
# z += (w + c) * x
# for differing constants a,b,c

# a's = [11,11,15,-11,15,15,14,-7,12,-6,-10,-15,-9, 0]
# b's = [ 1, 1, 1, 26, 1, 1, 1,26, 1,26, 26, 26,26,26]
# c's = [ 6,12, 8,  7, 7,12, 2,15, 4, 5, 12, 11,13, 7]
#
#
# b is 1: 11 <= a <= 15 => x = 1 => z *= 26 and z += w + c
# b is 26: -15 <= a <= 0 => x = 0 (if valid) => z //= b
# x = 0 happens there when w == z%26 + a <=> w - a = z % 26 = old_w + c
# x = 0 needs to happen because z == 0 needs to be guaranteed at the end

# n[0] to n[13] as A to N

# from the x = 0 contrains in the b = 26 case:
# D - -11 = C + 8
# H - -7  = G + 2
# J - -6  = I + 4
# K - -10 = F + 12
# L - -15 = E + 7
# M - -9  = B + 12
# N - -0  = A + 6

# maximize
# D = 6 => C = 9:     C = 9 and D = 6
# H = 4 => G = 9:     G = 9 and H = 4 
# J = 7 => I = 9:     I = 9 and J = 7
# F = 7 => K = 9:     F = 7 and K = 9
# L = 1 => E = 9:     E = 9 and L = 1
# B = 6 => M = 9:     B = 6 and M = 9
# A = 3 => N = 9:     A = 3 and N = 9

    36969794979199

  end

  def part2(_args) do

# minimize
# D = 1 => C = 4
# H = 1 => G = 6
# J = 1 => I = 3
# F = 1 => K = 3
# L = 1 => E = 9
# B = 1 => M = 4
# A = 1 => N = 7

    11419161313147 


  end
end

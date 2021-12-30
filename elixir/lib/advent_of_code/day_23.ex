defmodule AdventOfCode.Day23 do
  def part1(_args) do
    # by hand:

    #############
    #...........#
    ###A#C#B#B###
      #D#D#A#C#
      #########

    # 40 + 6

    #############
    #...B......A#
    ###A#C#.#B###
      #D#D#.#C#
      #########
    
    # 500

    #############
    #...B......A#
    ###A#.#.#B###
      #D#D#C#C#
      #########

    # 20 + 500

    #############
    #...B.....BA#
    ###A#.#C#.###
      #D#D#C#.#
      #########

    # 8000 + 30 + 60

    #############
    #..........A#
    ###A#B#C#.###
      #D#B#C#D#
      #########
      
    # 2 + 9000

    #############
    #.A........A#
    ###.#B#C#D###
      #.#B#C#D#
      #########

    # 3 + 9

    #############
    #...........#
    ###A#B#C#D###
      #A#B#C#D#
      #########

    # >>> 40+6+500+520+8090+9002+12
    18170
  end

  def part2(_args) do
    # by hand (this was pain)

    # failed first idea: fill second col with B's
    # => too high

    # idea: fill third col with C's, rather convenient because C's in second col
    # and the 4th col A and B are pretty cheap to move
    # and we can set up the B and A's to fill in the second col easily then

    #############
    #...........#
    ###A#C#B#B###
      #D#C#B#A#
      #D#B#A#C#
      #D#D#A#C#
      #########

    # 9 + 40 + 30

    #############
    #.......B.BA#
    ###.#C#.#B###
      #D#C#.#A#
      #D#B#A#C#
      #D#D#A#C#

    # 9 + 9 + 700 + 700

    #############
    #AA.....B.BA#
    ###.#.#.#B###
      #D#.#.#A#
      #D#B#C#C#
      #D#D#C#C#


    # fill second col

    # 40 + 5000

    #############
    #AA.D.B.B.BA#
    ###.#.#.#B###
      #D#.#.#A#
      #D#.#C#C#
      #D#.#C#C#
      
    # 50 + 60 + 70 + 60

    #############
    #AA.D......A#
    ###.#B#.#.###
      #D#B#.#A#
      #D#B#C#C#
      #D#B#C#C#
    
    # 3 + 700 + 700

    #############
    #AA.D.....AA#
    ###.#B#C#.###
      #D#B#C#.#
      #D#B#C#.#
      #D#B#C#.#

    # 9000 + 11000 + 11000 + 11000

    #############
    #AA.......AA#
    ###.#B#C#D###
      #.#B#C#D#
      #.#B#C#D#
      #.#B#C#D#

    # 5 + 5 + 9 + 9

    #############
    #...........#
    ###A#B#C#D###
      #A#B#C#D#
      #A#B#C#D#
      #A#B#C#D#

    # >>> 9+40+30+9+9+700+700+40+5000+50+60+70+60+3+700+700+9000+33000+5+5+9+9

    50208
  end

end

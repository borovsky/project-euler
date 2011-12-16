require './lib.rb'

BOARD = %w(
 GO   A1 CC1 A2  T1 R1 B1  CH1 B2 B3
 JAIL C1 U1  C2  C3 R2 D1  CC2 D2 D3
 FP   E1 CH2 E2  E3 R3 F1  F2  U2 F3
 G2J  G1 G2  CC3 G3 R4 CH3 H1  T2 H2)

CC_CARDS = %w(GGO G2J) + ['z'] * 14
CH_CARDS = %w(GGO G2J GC1 GE3 GH2 GR1 GNR GNR GNU GB3) + ['z'] * 6

MAX_MOVES = 10 ** 6

JAIL_POS = BOARD.index("JAIL")
GO_POS = BOARD.index("GO")
C1_POS = BOARD.index("C1")
E3_POS = BOARD.index("E3")
H2_POS = BOARD.index("H2")
R1_POS = BOARD.index("R1")

def roll(sum)
  [Random.rand(1..sum), Random.rand(1..sum)]
end

@cc_cards = CC_CARDS
@ch_cards = CH_CARDS

def get_card(cards)
  cards[Random.rand(0..cards.length)]
end

def calc_new_pos(pos)
  sig = BOARD[pos]

  case sig
  when /CH.?/
    card = get_card(@cc_cards)
    process_card(pos, card)
  when /CC.?/
    card = get_card(@ch_cards)
    process_card(pos, card)
  when "G2J"
    JAIL_POS
  else
    pos
  end
end

def find_next(pos, s)
  while true
    pos = (pos + 1) % BOARD.length
    return pos if BOARD[pos][0] == s
  end
end

def process_card(pos, card)
  case card
  when /^G(.+)/
    t = $1
    case $1
    when '2J'
      JAIL_POS
    when 'GO'
      GO_POS
    when 'NR'
      find_next(pos, 'R')
    when 'NU'
      find_next(pos, 'U')
    when 'C1'
      C1_POS
    when 'E3'
      E3_POS
    when 'H2'
      H2_POS
    when 'R1'
      R1_POS
    when 'B3'
      (pos + BOARD.length - 3) % BOARD.length
    else
      p 1
      pos
    end
  else
    pos
  end
end

def calc_top_probabilities(sum)
  prob = [0] * BOARD.length
  n = 0
  pos = 0
  while n < MAX_MOVES
    r = roll(sum)
    pos = calc_new_pos((pos + r[0] + r[1]) % BOARD.length)
    prob[pos] += 1
    if r[0] == r[1]
      r = roll(sum)
      pos = calc_new_pos((pos + r[0] + r[1]) % BOARD.length)
      prob[pos] += 1

      if r[0] == r[1]
        r = roll(sum)
        if(r[0] == r[1])
          pos = JAIL_POS
        else
          pos = calc_new_pos((pos + r[0] + r[1]) % BOARD.length)
        end
        prob[pos] += 1
      end
    end

    n +=1
    p n if n % 100_000 == 0
  end
  m = prob.sum
  r = []
  prob.each_with_index {|e,  idx| r << [e, BOARD[idx],idx]}
  r = r.sort_by {|e| -e.first}
  p r
  r[0..2].map{|e| sprintf("%02d", e[2])}.join("")
end

assert_eq 10, process_card(1, "G2J")
assert_eq 0, process_card(1, "GGO")
assert_eq 11, process_card(1, "GC1")
assert_eq 24, process_card(1, "GE3")
assert_eq 39, process_card(1, "GH2")
assert_eq 5, process_card(1, "GR1")
assert_eq 15, process_card(7, "GNR")
assert_eq 25, process_card(22, "GNR")
assert_eq 5, process_card(35, "GNR")
assert_eq 12, process_card(7, "GNU")
assert_eq 28, process_card(22, "GNU")
assert_eq 12, process_card(35, "GNU")
assert_eq 4, process_card(7, "GB3")
assert_eq 19, process_card(22, "GB3")
assert_eq 32, process_card(35, "GB3")

p calc_top_probabilities(6)
p calc_top_probabilities(4)

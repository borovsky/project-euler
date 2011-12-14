require './lib.rb'

@map = {}


def next_item(n)
  r = @map[n]
  return r if r
  @map[n] = n.digits.map{|d| factorial(d)}.inject(0, :+)
end

def cycle_length(n)
  items = {}
  while true
    items[n] = true
    n = next_item(n)
    return items.size if items[n]
  end
end

def count_cycles(len, upto)
  s = 0
  m = 0
  (2..upto).each do |i|
    cl = cycle_length(i)
    if cl == m
      s += 1
    elsif cl > m
      s = 1
      m = cl
      p [s, m, i]
    end
    p i if i % 10000 == 0
  end
  [s, m]
end

assert_eq 6, factorial(3)
assert_eq 120, factorial(5)

assert_eq 145, next_item(145)
assert_eq 363601, next_item(169)
assert_eq 1454, next_item(363601)

assert_eq 2, cycle_length(871)
assert_eq 3, cycle_length(169)
assert_eq 5, cycle_length(69)

p count_cycles(60, 1_000_000)

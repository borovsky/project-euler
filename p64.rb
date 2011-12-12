require './lib.rb'

def get_period(n)
  periods = {}

  a, b, c = first_step(n)
  sb, sc = b, c
  while true
    d, e, f = extract(n, b, c)
    periods[[b, c]] = [d, e, f]
    b, c = e, f
    return calc_cycle(periods, a, e, f) if(periods[[e, f]])
  end
end

def calc_cycle(p, a, b, c)
  r = []

  i, j = b, c
  while true
    rr, i, j = p[[i, j]]
    r << rr
    break if [i, j] == [b, c]
  end
  [a, r]
end

# sqrt(s) -> a + c/(sqrt(s) - b) , c == 1
# return a, b, c
def first_step(s)
  sq = s.floor_sqrt
  [sq, sq, 1]
end

# We have X = b/(sqrt(s) - a).
# In result we get [c, d, e]
# X = c + (sqrt(s) - d)/e, where 0 <(sqrt(s) + d)/e) <1
def extract(s, a, b)
  sq = s.floor_sqrt
  e = s - a * a
  raise "!!!" if (e % b > 0)
  e = e / b
  c = 1
  d = a - e
  while s > (d - e) * (d - e) #extracting part
    d -= e
    c += 1
  end
  return [c, -d, e]
end

def count_odd(n)
  i = 2
  c = 0
  while i <= n do
    c += 1 if !i.square? && get_period(i)[1].length.odd?
    i += 1
    p i if i% 1000 == 0
  end
  c
end

assert_eq first_step(2), [1, 1, 1]
assert_eq extract(23, 4, 1), [1, 3, 7]
assert_eq extract(23, 3, 7), [3, 3, 2]
assert_eq extract(23, 3, 2), [1, 4, 7]
assert_eq extract(3, 1, 1), [1, 1, 2]
assert_eq extract(3, 1, 2), [2, 1, 1]
assert_eq get_period(2), [1, [2]]
assert_eq get_period(3), [1, [1, 2]]
assert_eq count_odd(13), 4

puts count_odd(10000)

require './lib.rb'

def seq(n)
  k = 1
  r = []
  while k < n
    r += [1, 2 * k, 1]
    k += 1
  end
  r[0, n]
end

def calc_diff(s)
  s = s.reverse
  a, b = s[0], 1
  (1..(s.length - 1)).each do |i|
    n = s[i]
    a, b = n * a + b, a
  end
  [a, b]
end

def res(n)
  calc_diff([2] + seq(n - 1))[0].digits.reduce(0, :+)
end

assert_eq [1, 2, 1, 1, 4, 1], seq(6)
assert_eq [3, 2], calc_diff([1, 2])
assert_eq [7, 5], calc_diff([1, 2, 2])
assert_eq [17, 12], calc_diff([1, 2, 2, 2])
assert_eq [11, 4], calc_diff([2] + seq(3))
assert_eq [1457, 536], calc_diff([2] + seq(9))

assert_eq 17, res(10)

p res(100)

require './lib.rb'

def find_anss(d)
  x, y, s = 1, 1, d
  while true
    x, s = x + 1, s - 2 * x - 1 if s > 0
    y, s = y + 1, s + d * (2 * y + 1) if s < 0
    return [x, y] if s == 0
    p [x, y, s] if x % 100000 == 0
  end
end

def find_ans(n)
  m = Math.sqrt(n).ceil
  a, b, k = m, 1, m * m - n

  while k != 1
    m = (1..n * n).find do |i|
      (a * i + n * b) % k == 0 &&
        (a + b * i) % k == 0 &&
        (i * i - n) % k == 0
    end
    a, b, k = [(a * m + n * b) / k, (a + b * m) / k, (m * m - n) / k]
#    p [m, a, b, k]
  end
  [a.abs, b.abs]
end

def max_x(n)
  m, mx = 0
  (1..n).each do |i|
    p i
    unless i.square?
      x, y = find_ans(i)
      m, mx = x, i if m < x
    end
  end
  [m, mx]
end

assert_eq [3, 2], find_ans(2)
assert_eq [2, 1], find_ans(3)
assert_eq [9, 4], find_ans(5)
assert_eq [5, 2], find_ans(6)
assert_eq [8, 3], find_ans(7)

assert_eq [9, 5], max_x(7)

p max_x(1000)

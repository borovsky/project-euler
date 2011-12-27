require './lib.rb'

DESIRED_PROB = 1/2

TARGET = 1_000_000_000_000

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

def f(n)
  calc_diff([0] + seq(n))
end

i = 3
b, r = 0, 0

while b + r < TARGET
  l, k = f(i)
  p [l, k]
  
  j = 0
  pr = 1
  while pr != DESIRED_PROB
    j += 1
    pr = l  * (l * j - 1) / ((k * j + 1) * k)
  end

  b, r = [l * j, k * j + 1]
  p [b, r]
  i = i + 1
end


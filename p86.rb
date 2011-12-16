require './lib.rb'

def gen_count(m)
  s = 0
  1.upto(m + m) do |i|
    if(i * i + m * m).square?
      f, t = (i <= m) ? [1, i - 1] : [i - m, m]
      a = ((t - f + 2) / 2).to_i
      s += a
    end
  end
  s
end

def find_more_then_squares(n)
  i = 2
  s = 0
  while(s < n)
    i += 1
    s += gen_count(i)
    p [s, i] if i % 100 == 0
  end
  [s, i]
end

assert_eq 2, gen_count(3)
assert_eq 2060-1975, gen_count(100)
assert_eq [2060,100], find_more_then_squares(2_000)
p find_more_then_squares(1_000_000)


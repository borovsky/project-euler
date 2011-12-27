require './lib.rb'

MAX = 1_000_000_000

i = 0
pp = 0
s = 0

while 3 * i * i < MAX
  i += 1
  sq = i * i

  
#  if i.even?
    a = sq + 1
    if (3 * a * a - 2 * a - 1).square?
      p [:a, a, a, a + 1]
      s += 3 * a +1
    end
  #  end
  x = (sq * 2 + 1)
  if x % 3 == 0 && x > 3
    a = x / 3
    if (3 * a * a + 2 * a - 1).square?
      p [:b, a, a, a - 1]
      s += 3 * a -1
    end
  end
end

p s

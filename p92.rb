require './lib.rb'

@cache = {1 => 1, 89 => 89}
def calc(n)
  r = @cache[n]
  return r if r

  a = n.digits.map{|i| i * i}.sum
  if n < 2000
    @cache[n] = calc(a)
  else
    @cache[a]
  end
end

def ans(n)
  s = 0
  1.upto(n - 1) do |i|
    p i if i % 100_000 == 0
    s += 1 if calc(i) == 89
  end
  s
end

assert_eq 89, calc(85)
assert_eq 89, calc(89)
assert_eq 89, calc(145)

p ans(10_000_000)

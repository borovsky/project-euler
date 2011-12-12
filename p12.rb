n = 0
DIVS_2 = 250

def half_divisors(n)
  i = 1
  a = 0
  while i*i < n
    a += 1 if n%i == 0

    i += 1
  end
  a
end

s = 1
it = 2

len = half_divisors(s)

@max_len = 0

while len < DIVS_2
  s += it
  it += 1
  len = half_divisors(s)
  if len > @max_len
    puts "#{len} #{it} #{s}"
    @max_len = len
  end
end

p s

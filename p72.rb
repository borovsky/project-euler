require './lib.rb'

@phi = {}

def phi(n, primes)
  r = n
  pd = n.prime_dividers(primes)

  pd.each do |d|
    r = (r / d) * (d-1)
  end
  r
end

def count_fractions(d, primes)
  s = 0
  (2..d).each do |i|
    s += phi(i, primes)
    p i if i % 10000 == 0
  end
  s
end

MAX = 1_000_000

primes = primes_to(MAX)

assert_eq 21, count_fractions(8, primes)

p count_fractions(MAX, primes)

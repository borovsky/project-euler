require './lib.rb'

def phi(n, primes)
  r = n
  pd = n.prime_dividers(primes)

  #p pd
  pd.each do |d|
    r = (r / d) * (d-1)
  end
  r
end

primes = primes_to(1_000_000)

assert_eq 1, phi(2, primes)
assert_eq 2, phi(3, primes)
assert_eq 2, phi(4, primes)
assert_eq 4, phi(5, primes)
assert_eq 2, phi(6, primes)
assert_eq 6, phi(7, primes)
assert_eq 4, phi(8, primes)
assert_eq 6, phi(9, primes)
assert_eq 4, phi(10, primes)

m = 0
mn = 0
(2..1_000_000).each do |i|
  next unless i % 2 == 0 && i % 3 == 0
  p = phi(i, primes)
  if((i / p.to_f) > m)
    m = i / p.to_f
    mn = i
  end
  p i if i % 10000 == 0
end

p [m, mn]

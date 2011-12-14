require './lib.rb'

@cache = {}

def calc(n, m, primes)
  return 0 if n < 0
  return 1 if n == 0

  return @cache[[n, m]] if @cache[[n, m]]

  res = 0
  i = 0
  while primes[i] <= m
    pr = primes[i]
    res += calc(n - pr, pr, primes)
    i += 1
  end
  res
  @cache[[n, m]] = res
end

primes = primes_to 1000

def calcs(n, primes)
  calc(n, n, primes)
end
assert_eq 5, calcs(10, primes)
i = 11
while true
  if calcs(i, primes) > 5_000
    p i
    break
  end
  i += 1
end

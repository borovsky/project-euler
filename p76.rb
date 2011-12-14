require './lib.rb'

@p = {}

def pr(k, n)
  return 0 if k > n
  return 1 if k == n

  return @p[[k, n]] if @p[[k, n]]
  s = (pr(k + 1, n) + pr(k, n - k))
  @p[[k, n]] = s
  @p[[k, n]]
end

def parts(n)
  pr(1, n) - 1
end

assert_eq 6, parts(5)
p parts(100)

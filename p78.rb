require './lib.rb'

@p = {}

def pentagonal(n)
  n * (3 * n - 1) / 2
end

def generalized_pentagonal(n)
  return 0 if n < 0
  return pentagonal(n / 2 + 1) if n % 2 == 0
  pentagonal(-(n/2 + 1).to_i)
end

n = 1
pt = [1]
while true
  r = 0
  f = -1
  i = 0
  while true
    k = generalized_pentagonal(i)
    break if(k > n)
    f = -f if i % 2 == 0

    r += f *pt[n - k]
    i += 1
  end
  pt << r
  if r % 1_000_000 == 0
    p [n, r]
    break
  end
  p n if n % 1000 == 0
  n += 1
end

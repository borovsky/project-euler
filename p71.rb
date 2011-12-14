require './lib.rb'

def cmp(a,b)
  a[0] * b[1] <=> a[1] * b[0]
end

def find_ceil(r, d_max)
  m = [0, 1]

  d = r[1]
  d = d_max - d_max % d
  n = r[0] * d/r[1]
  while(d > 1)
    c = cmp([n, d], r)
    if c < 0
      m = [n, d] if cmp(m, [n, d]) < 0
      d = d - 1
    else
      n = n - 1
    end
    p [n, d] if d % 10000 == 0
  end
  m
end

assert_eq [2, 5], find_ceil([3, 7], 8)


p find_ceil([3, 7], 1_000_000)

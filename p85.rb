require './lib.rb'

def calc_count(n, m)
  n * (n + 1) * m * (m+1)/ 4
end

def find_nearest(k)
  res = 0
  ans = [0, 0]
  n = 1
  m = Math.sqrt(k).ceil
  while m > 1
    c = 0
    while (c = calc_count(n, m)) > k
      if((c - k).abs < (k - res).abs)
        ans = [n, m]
        res = c
        p [n, m, res, ans]
      end
      m -= 1
    end
    if((c - k).abs < (k - res).abs)
      ans = [n, m]
      res = c
      p [n, m, res, ans]
    end
    n += 1
  end
  ans
end

assert_eq 18, calc_count(2, 3)
r = find_nearest(2_000_000)

p [r, r[0] * r[1]]

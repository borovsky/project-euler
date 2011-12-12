require 'lib'

def is_pent(x)
  r = ((1 + Math::sqrt(1+24*x)) /6).round
  (3*r*r-r)/2 == x
end

def pent(n)
  (3*n - 1) * n / 2
end

s = 2
while true
  k = s - 1
  puts s if s % 100 == 0
  ps = pent(s)
  pk = pent(k)
  pj = ps - pk
  while(pj < pk)
    if is_pent(pj)
      pd = pk-pj
      puts pd if is_pent(pd)
    end
    k -= 1
    pk = pent(k)
    pj = ps - pk
  end
  s += 1
end

require 'lib'

@primes = [2]

N = 4

s = 3
c=0

@divs = [0, 0, 1]

def calc_divs(n)
  @primes.each do |p|
    if n % p == 0
      ns = n
      ns = ns.div(p) while ns % p == 0
      d = @divs[ns]+1
      @divs << d
      return d
    elsif p * p > n
      @primes << n
      @divs << 1
      return 1
    end
  end
end

while true
  p s if s % 10000 == 0
  
  div = calc_divs(s)

  if div == 0
    if (c == N)
      puts s-c
      exit 0
    end
    c = 0
    @primes << s
  elsif div == N
    c += 1
  else
    if (c == N)
      puts s-c
      exit 0
    end
    c = 0
  end
  s += 1
end

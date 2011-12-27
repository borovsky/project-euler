require './lib.rb'

@chains = {}

MAX = 1_000_000

def chain_length(n)
  found = { n => true}
  hist = [n]
  while true
    x = proper_divisors(n).sum
    if found[x]
      x = hist.rindex(x)
      cycle = hist[x..-1]
      found.keys.each{|k| @chains[k] = cycle}
      return cycle.length
    elsif @chains[x]
      return @chains[x].length
    elsif x >= MAX
      return [].length
    else
      found[x] = true
      hist << x
      n = x
    end
  end
end

assert_eq 1, chain_length(28)
assert_eq 2, chain_length(220)

x = 0
mn = 0
ml = 0
1.upto(1_000_000) do |n|
  p n if n % 1_000 == 0
  l = chain_length(n)
  if(l > ml)
    mn, ml = n, l
    p [n, l]
  end
end

p @chains[mn].min

require 'lib'

MONETS = [1, 2, 5, 10, 20, 50, 100, 200]
SUM = 200

@pos = Array.new(SUM + 1)
@pos = @pos.map {|i| Array.new(MONETS.last + 1) }

@pos[0] = 1

def calc(n, max_monet)
  return 0 if n < 0
  return 1 if n == 0
  return @pos[n][max_monet] if @pos[n][max_monet]

  res = MONETS.map {|i| i <= max_monet ? calc(n-i, i) : 0 }.sum
  @pos[n][max_monet] = res
end

puts calc(SUM, MONETS.last)

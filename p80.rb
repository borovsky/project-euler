require './lib.rb'

DIGITS = 100

def sqrt_digits(n)
  return 0 if n.square?

  d = Math.sqrt(n).to_s
  point = d.index(".")
  d = d.gsub('.', '')
  d += '0' while(d.length < DIGITS * 3)
  point = d.length - point
  divider = 10 ** point
  target = (n.to_s + '0' * (point * 2)).to_i
  d = d.to_i

  diff = 1
  while diff.abs > 0
    diff = ((target - d * d)/(divider * n * Math.sqrt(n)).to_i).to_i
    d += diff
  end
  d.to_s[0...DIGITS].to_i.digits.sum
end

assert_eq 0, sqrt_digits(4)
assert_eq 475, sqrt_digits(2)
p (1..100).map{|i| p i; sqrt_digits(i)}.sum

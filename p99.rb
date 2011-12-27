require './lib.rb'

STEP = 100_000

def big_pow_log(a, b)
  Math.log(a) * b
end

m = 0
ml = 0
File.new("base_exp.txt").readlines.each_with_index do |l, i|
  l = l.strip
  a, b = l.split(",")
  p = big_pow_log(a.to_i, b.to_i)
  m, ml = p, i if p > m
end

p ml

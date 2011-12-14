require './lib.rb'

def phi(n, primes)
  r = n
  pd = n.prime_dividers(primes)

  pd.each do |d|
    r = (r / d) * (d-1)
  end
  r
end

def split_sorted(arr, split)
  pr2 = []
  i_l = 0
  arr.each_with_index do |e, i|
    if e < 400
      pr2 << e
      i_l = i
    else
      return [pr2, arr.slice(i_l, arr.length)]
    end
  end
  [arr, pr2]
end

MAX = 10_000_000

primes = primes_to(MAX)

min_diff, min_n = 100, 0

pr2, primes = split_sorted(primes, 400)
p [pr2.length, primes.length]
p "!!"

(2...MAX).each do |i|
  p i if i % 10001 == 0
  next if pr2.find{|e| i % e == 0}
  ph = phi(i, primes)
  if ph.digits.sort == i.digits.sort
    if min_diff > i.to_f / ph
      p [i.to_f / ph, i, ph]
      min_diff, min_n = i.to_f / ph, i
    end
  end
end

p "Ans: ", [min_diff, min_n]

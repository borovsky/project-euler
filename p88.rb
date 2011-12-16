require './lib.rb'

def calc_min_sum(val, variants, max)
#  p [val, variants, max]
  folding = {}
  variants.each do |s|
    min_sum = s.sum + max - s.length
    if min_sum == val
      return val
    elsif min_sum < val && s.length > 1 #trying to resplit sum
      s.each_with_index do |v, i|
        ss = s.dup
        ss.delete_at i
        ss.each_with_index do |ee, idx|
          sss = ss.dup
          sss[idx] *= v
          folding[sss.sort] = true
        end
      end
    end
  end
  return false if folding.empty?
  return calc_min_sum(val, folding.keys, max)
end

def min_split(n, primes)
  i = 2
  while true
    s = i.prime_dividers_not_uniq(primes)
    r = calc_min_sum(i, [s], n)
    return r if r
    i += 1
  end
end

def sum_ps(m, primes)
  set = {}
  2.upto(m) do |i|
    set[min_split(i, primes)] = true
    p i if i % 100 == 0
  end
  set.keys.sum
end

primes = primes_to(1_000_000)

assert_eq 4, calc_min_sum(4, [[2, 2]], 2)
assert_eq 6, calc_min_sum(6, [[2, 3]], 3)

assert_eq 4, min_split(2, primes)
assert_eq 6, min_split(3, primes)
assert_eq 8, min_split(4, primes)
assert_eq 8, min_split(5, primes)
assert_eq 12, min_split(6, primes)

assert_eq 30, sum_ps(6, primes)
assert_eq 61, sum_ps(12, primes)

p sum_ps(12_000, primes)

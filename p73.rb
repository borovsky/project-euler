require './lib.rb'


def count_fractions(d, primes)
  cnt = 0
  (4..d).each do |i|
    s = ((i + 2) / 3).to_i
    e = (i / 2 - ((i + 1) % 2)).to_i
    (s..e).each do |j|
      cnt += 1 if nod(i, j) == 1
    end
    p i if i % 1000 == 0
  end
  cnt
end

MAX = 12_000

primes = primes_to(MAX)

assert_eq 3, count_fractions(8, primes)

p count_fractions(MAX, primes)

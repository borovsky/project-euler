require './lib.rb'

def add_collection(nums, collection, max)
  m = {}
  nums.each do |n|
    i = 0
    while i < collection.length
      c = collection[i]
      if (n + c < max)
        m [n + c] = true 
      else
        break
      end
      i+= 1
    end
  end
  m.keys
end

def count(max, sq_primes, cb_primes, qd_primes)
  a = {}
  for qd in qd_primes
    break if qd >= max
    for cb in cb_primes
      s = qd + cb
      break if s >= max
      for sq in sq_primes
        r = s + sq
        if r < max
          a[r] = true
        else
          break
        end
      end
    end
  end
  a.size
end

MAX = 50_000_000
primes = primes_to 100_000
sq_primes = primes.map{|p| p * p}
cb_primes = primes.map{|p| p * p * p}
qd_primes = primes.map{|p| p * p * p * p}

assert_eq 4, count(50, sq_primes, cb_primes, qd_primes)

p count(MAX, sq_primes, cb_primes, qd_primes)



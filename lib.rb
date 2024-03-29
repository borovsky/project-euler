require 'set'
require 'mathn'

def half_divisors(n)
  i = 1
  a = []
  while i*i <= n
    a << i if n%i == 0

    i += 1
  end
  a
end

def proper_divisors(n)
  d = half_divisors(n)
  ds = d[-1]
  dd = d[0, d.length]
  if ds * ds == n
    dd = dd[0, dd.length - 1]
  end
  dd.delete(1)
  d + dd.reverse.map {|i| n/i }
end

@factorial = {1 => 1, 0 => 1}
def factorial(n)
  @factorial[n] || @factorial[n] = n * factorial(n-1)
end

module Enumerable
  def sum
    inject {|s, i| s+i}
  end
end

class Array
  #ret index, that a[index] > n, and a[index-1] < n
  def bsearch(n)
    l = self.length / 2
    suc = l/2
    while true
      if(self[l] < n)
        l += suc
        suc /= 2
      elsif self[l] > n
        l -= suc
        suc /= 2
      else
        return l
      end
      if(suc == 0)
        l -= 1 while l > 0 and self[l-1] > n
        l += 1 while l < self.length-1 and self[l] < n
        return l
      end
    end
  end

  PANDIGIT_BASE = (1..9).to_a

  def pandigital?
    return false unless self.length == 9
    self.sort == PANDIGIT_BASE
  end

  # calculates count of permutations
  def permutations
    perm = factorial(length)
    h = {}
    each {|i|
      h[i] ||= []
      h[i] << i
    }
    h.each_value {|v|
      perm /= factorial(v.length)
    }
    perm
  end

  def swap(i, j)
    t = self[i]
    self[i] = self[j]
    self[j] = t
  end

  def next_perm
    l = length - 1
    # 1) search for first order fail
    l -= 1 while l > 0 and self[l-1] >= self[l]
    return nil if l == 0

    # 2) search for element, that directly bigger than current
    tst = self[l-1]
    idx = l
    idx += 1 while idx < length and tst <= self[idx]
    if idx > length && tst > self[idx]
      swap(l-1, idx-1)
    else
      swap(l-1, l)
    end

    # 3) sort to end
    r = length - 1
    while l < r
      swap(l, r)
      l, r = l+1, r-1
    end
    self
  end

  def get_perm(n)
    return self if self.length == 1
    a = self.dup.sort
    items = a.uniq
    i = 0

    while i < items.length
      other = a.dup
      other.delete_at(i)
      perms = other.permutations
      if(n < perms)
        return [a[i]] + other.get_perm(n)
      end
      n -= perms
      i += 1
    end
  end

  def digits_to_num
    n = 0
    self.each{|s|
      n = n*10 + s
    }
    n
  end

  def shuffle
    sort_by { rand }
  end
end

class Numeric
  def digits
    zero = "0".each_byte.first
    to_s.each_byte.map{|i| i - zero}
  end

  def mprime?(primes = [])
    return true if self == 2
    return false if self < 2
    return false if self % 2 == 0

    i = 3
    primes.each do |p|
      return false if self % p == 0
      return true if p * p > self
      i = p
    end
    i = 3 if i<3

    while(i * i < self)
      return false if self % i == 0
      i += 2
    end
    true
  end

  def square?
    s = Math.sqrt(self).round
    s*s == self
  end

  def floor_sqrt
    s = Math.sqrt(self).round
    (s * s > self) ? (s - 1) : s
  end

  def prime_dividers(primes)
    n = self
    d = []
    primes.each do |p|
      d << p if n % p == 0
      n /= p while n % p == 0
      return d if n == 1
    end
    return d
  end

  def prime_dividers_not_uniq(primes)
    n = self
    d = []
    primes.each do |p|
      while n % p == 0
        d << p
        n /= p 
      end
      return d if n == 1
    end
    return d
  end
end

def primes_to(max)
  primes_file_name = "primes.#{max}"
  return Marshal.load(File.read(primes_file_name)) if File.exists?(primes_file_name)
  primes = [2, 3, 5]
  s = 6
  while(s < max) do
    primes << (s+1) if (s+1).mprime?(primes)
    primes << (s+5) if (s+5).mprime?(primes)
    s += 6
    p s if s % 10000 == 0
  end
  File.open(primes_file_name, "w") do |f|
    f.write(Marshal.dump(primes))
  end
  primes
end


def assert(cond, message = "Error in test!")
  raise message unless cond
end

def assert_eq(a, b, message = "Error: #{a.inspect} != #{b.inspect}")
  raise message unless a == b
end

def gcd(a, b)
  return 1 if b == 1
  n = a % b
  n == 0 ? b : gcd(b, a % b)
end

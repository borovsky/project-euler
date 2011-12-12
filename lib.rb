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

def factorial(n)
  return 1 if n<2
  n * factorial(n-1)
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
    l -= 1 while l>0 and self[l-1] >= self[l]
    return nil if l == 0

    # 2) search for element, that directly bigger than current
    tst = self[l-1]
    idx = l
    idx += 1 while idx < length and tst <= self[idx]
    swap(l-1, idx-1)

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
end

class Numeric
  def digits
    zero = "0".each_byte.first
    to_s.each_byte.map{|i| i - zero}
  end

  def prime?(primes = [])
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
end

def primes_to(max)
  simples = [2]
  s = 3
  while(s < max) do
    unless simples.find {|i| s % i == 0}
      simples << s
    end
    s += 2
  end
  simples
end


def assert(cond, message = "Error in test!")
  raise message unless cond
end

def assert_eq(a, b, message = "Error: #{a.inspect} != #{b.inspect}")
  raise message unless a == b
end

def nod(a, b)
  n = a % b
  n == 0 ? a : nod(b, a % b)
end

require 'lib'

@primes = primes_to(10_000)
@primes_set = Set.new(@primes)


def r_truncatable?(prime)
  return false if prime < 10

  dig = prime.digits
  r_trunc = dig[0, dig.length - 1].digits_to_num
  @primes_set.include?(r_trunc) && (r_trunc < 10 or r_truncatable?(r_trunc))
end

def l_truncatable?(prime)
  return false if prime < 10

  dig = prime.digits
  l_trunc = dig[1, dig.length - 1].digits_to_num
  @primes_set.include?(l_trunc) && (l_trunc < 10 or l_truncatable?(l_trunc))
end

def next_gen_l(list)
  new = []
  list.each do|i|
    dig = i.digits
    (1..9).each{|s|
      nn = ([s] + dig).digits_to_num
      new << nn if nn.prime?(@primes)
    }
  end
  new
end

def next_gen_r(list)
  new = []
  list.each do|i|
    (1..9).each{|s|
      nn = i * 10 + s
      new << nn if nn.prime?(@primes)
    }
  end
  new
end


l_trunc = @primes.find_all {|i| l_truncatable?(i)}
r_trunc = @primes.find_all {|i| r_truncatable?(i)}

ans = Set.new(l_trunc & r_trunc)
p ans.to_a.sort

l_trunc = l_trunc.find_all {|i| i > 1_000 && !i.digits.include?(0)}
r_trunc = r_trunc.find_all {|i| i > 1_000}

p l_trunc
p r_trunc
puts "--------------------------"

while !l_trunc.empty? && !r_trunc.empty?
  l_trunc = next_gen_l(l_trunc)
  r_trunc = next_gen_r(r_trunc)
  ans += l_trunc & r_trunc

  p l_trunc
  p r_trunc
  p ans
end

puts "--------------------------"
p ans
p ans.sum

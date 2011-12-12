require 'lib'

r = []

(1..9999).each {|s|
  div = proper_divisors(s).sum

  if(div != s and proper_divisors(div).sum == s)
    r << s
  end
}


p r
p r.sum

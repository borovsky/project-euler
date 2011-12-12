require 'lib'

def test(a, b)
  g = a.gcd b
  return if g == 1
  a1, b1 = a/g, b/g
  puts([a,b, a1, b1].join(" "))
end

(10..98).each do |a|
  ((b+1)..99).each do |b|
    test(a, b)
  end
end

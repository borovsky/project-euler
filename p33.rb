require 'lib'

r = []

def test(a, b)
  g = a.gcd b
  return if g == 1 or g%10 == 0 or g%11 == 0
  a1, b1 = a/g, b/g
  if b1 < 10
    test2(a, b, a1, b1)
  end
end

def test2(a, b, a1, b1)
  a_s = a.to_s
  a_a = a_s.each_char.to_a
  b_s = b.to_s
  b_a = b_s.each_char.to_a

  (1..9).each do|i|
    m2 = b1 * i
    return if m2 >= 10

    m1 = a1 * i
    if a_s.include?(m1.to_s) and b_s.include?(m2.to_s)
      puts [a, b, a1, b1].join(" ") if a_a - [m1.to_s] == b_a - [m2.to_s]
    end
  end
end

(10..98).each do |a|
  ((a+1)..99).each do |b|
    test(a, b)
  end
end

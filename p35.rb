require 'lib'

@r = []

def test_poly(n)
  return if n>1_000_000
  s = sprintf("%b", n)
  p s if n == 99
  c = s.length / 2
  f = s[0, c].each_char.to_a.reverse.join("")

  if(s[-c, c] == f)
    @r << n
    puts "#{n} #{s}"
  end
end


(0..9).each do |s|
  test_poly([s].digits_to_num)
end
(1..999).each do |b|
  if b % 2 == 1
    digits = b.digits
    test_poly((digits.reverse + digits).digits_to_num)
    (0..9).each do |s|
      test_poly((digits.reverse + [s] + digits).digits_to_num)
    end
  end
  if b % 10 == 0
    digits = b.digits
    test_poly((digits + digits.reverse).digits_to_num)
    (0..9).each do |s|
      test_poly((digits + [s] + digits.reverse).digits_to_num)
    end
  end
end

puts @r.sum

require 'lib'

MAX = 7 * factorial(9)

r = []

FAC = (0..9).map{|i| factorial(i)}

(10..MAX).each do |i|

  if i.digits.map{|d| FAC[d]}.sum == i
    p i
    r << i
  end
  puts "   #{i}" if i % 100000 == 0
end

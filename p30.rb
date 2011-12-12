require 'lib'

POW = 5

dig = (0..9).to_a.map{|i| i ** POW}
@max_val = dig[-1]* 6
p @max_val

a = []

(2..@max_val).each do |n|
  if n.digits.map{|i| dig[i]}.sum == n
    a << n
    puts n
  end
end

puts a.sum

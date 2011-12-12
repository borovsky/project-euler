def fac(n)
  return 1 if n < 2
  n * fac(n-1)
end

puts fac(100)
puts fac(100).to_s.each_char.map{|c| c.to_i}.inject{|s, i| s + i}

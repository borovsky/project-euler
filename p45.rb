require 'lib'

def is_pent(x)
  r = ((1 + Math::sqrt(1+24*x)) /6).round
  (3*r*r-r)/2 == x
end

def is_tri(x)
  r = ((Math::sqrt(1+8*x) - 1) /2).round
  r * (r+1) / 2 == x
end

def hexa(n)
  n * (n + n - 1)
end


i = 1
c = 0
while c < 3
  puts "       #{i}" if i%100 == 0
  n = i * (i+i-1)
  if is_pent(n)# and is_tri(n)
    puts n
    c += 1
  end
  i+= 1
end

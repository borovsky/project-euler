a = 1
b = 1
i = 2

MAX = 10**999

while a < MAX
  a, b, i = a+b, a, i+1
end

p a.to_s.length
p i

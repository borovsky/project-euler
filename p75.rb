require './lib.rb'

def count_triangles(len)
  count = Hash.new(0)

  n = 2
  while(n * n < len)
    m = 1
    while m < n
      if gcd(n, m) == 1 and (m - n) % 2 == 1
        l = 2 * n * (n + m)
        if l > len
          break
        else
          x = 1
          count[x * l], x = count[x * l] + 1, x + 1 while x * l < len
        end
      end
      m += 1
    end
    n += 1
    p n if n % 1000 == 0
  end
#  p count
  count.each_value.find_all{|v| v == 1}.length
end

assert_eq 6, count_triangles(50)
p count_triangles 1_500_000

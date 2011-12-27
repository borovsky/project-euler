require './lib.rb'


def count_other_triangles(m)
  ans = 0
  # generate new triangles
  1.upto(m) do |x|
    1.upto(m) do |y|
      g = gcd(x, y)
      dx, dy = x / g, y / g
      da = [y / dx, (m - x) / dy].min.to_i * 2
      ans += da
    end
  end
  ans
end

def calc(m)
  count_other_triangles(m) + m * m * 3
end

assert_eq 3, calc(1)
assert_eq 14, calc(2)
assert_eq 33, calc(3)
assert_eq 62, calc(4)
assert_eq 101, calc(5)
assert_eq 148, calc(6)

#assert_eq 353, calc(9)

p calc(50)

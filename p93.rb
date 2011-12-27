require './lib.rb'

def gen_all_nums(a, b)
  [a + b, a - b, a * b, a / b]
end


def generate_numbers(r)
  if r.length == 2
    gen_all_nums(r[0], r[1])
  else
    res = []
    r.permutation do |a|
      o = gen_all_nums(a[0], a[1])
      o.each do |e|
        s = generate_numbers([e] + a[2..-1].sort)
        res += s
      end
    end
    res.sort.uniq.find_all{|i| i == i.to_i && i >= 1}
  end
end

def max_conc_set(a, b, c, d)
  s = generate_numbers([a, b, c, d])
  m = 0
  l = 0
  pr = -1
  s.each do |v|
    if v - pr == 1
      l += 1
      m = l if l > m
    else
      l = 1
    end
    pr = v
  end
  p [s, m] if [a, b, c, d] == [1, 2, 5, 8]
  m
end

tst = generate_numbers([1, 2, 3, 4])

assert_eq 31, tst.length
assert tst.include? 8
assert tst.include? 14
assert tst.include? 19
assert tst.include? 36

assert_eq 28, max_conc_set(1, 2, 3, 4)

p "!!!"
r = [0, 0, 0, 0]
m = 0

1.upto(9) do |a|
  (a+1).upto(9) do |b|
    (b + 1).upto(9) do |c|
      (c + 1).upto(9) do |d|
        s = max_conc_set(a, b, c, d)
        if s > m
          r = [a, b, c, d]
          m = s
        end
      end
    end
  end
end

p [m, r]

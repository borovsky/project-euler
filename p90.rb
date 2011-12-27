require './lib.rb'

def gen_all_cubes(c)
  r = {}
  if c.length == 6
    r[c] = true
  else
    o = (0..9).to_a - c
    o.each do |i|
      ct = c.dup
      ct << i
      ct.sort!
      gen_all_cubes(ct).each {|cn| r[cn] = true}
    end
  end
  r.keys
end

squares = (1..9).map do |i|
  sq = (i * i).digits
  sq += [0] if sq.length == 1
  sq.sort
end

def calc_results(cubes, squares)
  ans = 0
  cubes.map!{|c| c.map{|e| [6, 9].include?(e) ? -1 : e}}
  squares.map!{|c| c.map{|e| [6, 9].include?(e) ? -1 : e}}

  0.upto(cubes.length - 1).each do |i|
    c1 =  cubes[i]
    (i+1).upto(cubes.length - 1).each do |j|
      c2 =  cubes[j]
      if squares.all? do |sq|
          (c1.include?(sq[0]) and c2.include?(sq[1])) or
            (c2.include?(sq[0]) and c1.include?(sq[1]))
        end
        ans += 1
      else
      end
    end
  end
  ans
end

assert_eq [[1, 2, 3, 4, 5, 7]], gen_all_cubes([1, 2, 3, 4, 5, 7])
assert_eq [[0, 1, 2, 3, 4, 5], [1, 2, 3, 4, 5, 6], [1, 2, 3, 4, 5, 7], [1, 2, 3, 4, 5, 8], [1, 2, 3, 4, 5, 9]], gen_all_cubes([1, 2, 3, 4, 5]).sort

p calc_results(gen_all_cubes([]), squares)

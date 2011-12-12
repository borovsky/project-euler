require 'lib'

FULL = (0..9).to_a

def limit(list, div, pos)
  res = []
  list.each do |i|
    r = i.dup
    digits = FULL - r
    sub = i[pos, 3]
    nilpos = sub.index {|i| i.nil?}
    if nilpos != 2
      digits.each do |d|
        r[nilpos+pos] = d
        l2 = limit([r], div, pos)
        res += l2
      end
    else
      digits.each do |d|
        r[nilpos+pos] = d
        sub[nilpos] = d
        if sub.digits_to_num % div == 0
          res << r.dup
        end
      end
    end
  end
  res
end

r1 = limit([Array.new(10)], 2, 1)
p r1.length
r2 = limit(r1, 3, 2)
p r2.length
r3 = limit(r2, 5, 3)
p r3.length
r4 = limit(r3, 7, 4)
p r4.length
r5 = limit(r4, 11, 5)
p r5.length
r6 = limit(r5, 13, 6)
p r6.length
r7 = limit(r6, 17, 7)
p r7.length

r7.each {|i|
  i[0] = (FULL - i)[0]
}

p r7.map {|i| i.digits_to_num}.sum

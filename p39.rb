require 'lib'

MAX_PERIMETER = 1_000

ans = {}

sqr_map = {}
(1..MAX_PERIMETER).each {|i|
  sqr_map[i*i] = i
}

(1..500).each do |a|
  (a..500).each do |b|
    c = sqr_map[a*a + b*b]
    if (c) and (a+b+c <= MAX_PERIMETER)
      per = a+b+c
      ans[per] ||= []
      ans[per] << [a, b, c]
    end
  end
end

max_ans = 0

ans.each do|p, a|
  if a.length >= max_ans
    puts "#{p} #{a.length}"
    p a
    max_ans = a.length
  end
end

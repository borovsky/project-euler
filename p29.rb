s = []

(2..100).each do |a|
  (2..100).each do |b|
    s << a ** b
  end
end

r = s.sort.uniq
puts r.length

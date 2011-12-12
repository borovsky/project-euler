require 'lib'

data = File.read("words.txt").gsub('"', "").split(",")

A_CODE = "A"[0]

def score(s)
  s.each_byte.map {|l| l-A_CODE + 1}.sum
end

triangles = Set.new((1..50).to_a.map{|i| (i *(i+1))/2})

puts data.size
tr =  data.find_all{|w| triangles.include?(score(w))}
p tr
p tr.length

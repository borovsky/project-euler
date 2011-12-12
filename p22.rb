require 'lib'

data = File.read("names.txt").gsub('"', "").split(",")

data.sort!

A_CODE = "A"[0]

def score(s)
  s.each_byte.map {|l| l-A_CODE + 1}.sum
end

s = 0
data.each_with_index {|e, i|
 s += score(e) * (i+1)
}

puts s

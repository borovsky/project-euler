NORM_LEN = [31, 28, 31, 30, 31, 31, 30, 31, 30, 31, 30, 31]
VIS_LEN  = [31, 29, 31, 30, 31, 31, 30, 31, 30, 31, 30, 31]

count = 0

s = (0 + 365) % 7

def vis?(n)
  n % 4 == 0
end

(1901.. 1999).each do |year|
  days = []
  if(vis?(year))
    days = VIS_LEN
  else
    days = NORM_LEN
  end
  
  days.each do|d|
    count += 1 if(s == 6)
    s = (s + d) % 7
  end
end

p count

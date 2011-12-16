require './lib.rb'

ROMANS = {'M' => 1000, 'D' => 500, 'C' => 100, 'L' => 50, 'X' => 10, 'V' => 5, 'I' => 1}

def roman_to_int(s)
  a = s.each_char.map{|c| ROMANS[c]}
  r = []
  i = 0
  while i < a.length
    if a[i] == 1 && (a[i+1] == 5 || a[i + 1] == 10)
      r << a[i + 1] - a[i]
      i += 2
    elsif a[i] == 10 && (a[i+1] == 50 || a[i + 1] == 100)
      r << a[i + 1] - a[i]
      i += 2
    elsif a[i] == 100 && (a[i+1] == 500 || a[i + 1] == 1000)
      r << a[i + 1] - a[i]
      i += 2
    else
      r << a[i]
      i += 1
    end
  end
  r.sum
end

def int_to_roman(i)
  r = ""
  while i >= 1000
    r << "M"
    i -= 1000
  end
  if i >= 900
    r << "CM"
    i -= 900
  end
  if i >= 500
    r << "D"
    i -= 500
  end
  if i >= 400
    r << "CD"
    i -= 400
  end
  while i >= 100
    r << "C"
    i -= 100
  end
  if i >= 90
    r << "XC"
    i -= 90
  end
  if i >= 50
    r << "L"
    i -= 50
  end
  if i >= 40
    r << "XL"
    i -= 40
  end
  while i >= 10
    r << "X"
    i -= 10
  end
  if i >= 9
    r << "IX"
    i -= 9
  end
  if i >= 5
    r << "V"
    i -= 5
  end
  if i >= 4
    r << "IV"
    i -= 4
  end
  while i >= 1
    r << "I"
    i -= 1
  end
  r
end

def opt_len(f)
  i = roman_to_int(f)
  r = int_to_roman(i)
  p [f, i, r]
  f.length - r.length
end

assert_eq 16, roman_to_int('IIIIIIIIIIIIIIII')
assert_eq 16, roman_to_int('VIIIIIIIIIII')
assert_eq 16, roman_to_int('VVIIIIII')
assert_eq 16, roman_to_int('XIIIIII')
assert_eq 16, roman_to_int('VVVI')
assert_eq 16, roman_to_int('XVI')

assert_eq 14, roman_to_int('XIV')

assert_eq 13, opt_len('IIIIIIIIIIIIIIII')

s = 0
File.readlines("roman.txt").each do |l|
  l = l.strip
  s += opt_len(l)
end
p s

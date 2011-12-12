WORDS = %w(zero one two three four five six seven eight nine)
DEC_WORDS = %w(ten twenty thirty forty fifty sixty seventy eighty ninety)
OTHER = %w(eleven twelve thirteen forteen fifteen sixteen seventeen eighteen nineteen)

def word(n)
  WORDS[n]
end

def hundreds(n)
  return nil if n == 0
  word(n) + " hundred"
end

def decimals(n)
  return nil if n == 0 
  return word(n) if n < 10
  return DEC_WORDS[n/10 - 1] if n % 10 == 0
  return OTHER[n-11] if n < 20
  return DEC_WORDS[n/10 - 1] + "-" + WORDS[n % 10]
end

def to_words(n)
  return "one thousand" if n == 1000
  h = hundreds(n / 100)
  d = decimals(n % 100)
  if h
    if d
      h + " and " + d
    else
      h
    end
  else
    if d
      d
    else
      "zero"
    end
  end
end

def letters(s)
  s2 = s.gsub(' ', '').gsub("-", "").gsub(",", "").gsub("\n", "")
  s2.length
end

s = (1..1000).map{|i|
  to_words(i)
}.join("\n")
puts s
puts letters(s)

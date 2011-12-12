require 'lib'

@primes = [2]
@pr2 = []

s = 3

while true
  puts s if s % 1000 == 1
  if s.prime?(@primes)
    @primes << s
    @pr2 << s
  else
    unless @pr2.find {|p| ((s - p)/2).square?}
      puts s
      exit 0
    end
  end
  s += 2
end

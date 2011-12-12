require 'lib'
@primes = Set.new(primes_to(5_000))

def is_prime(n)
  @primes.include? n
end

def primes_length(a,b)
  i = 0
  i += 1 while is_prime(i * i + a * i + b)
  i
end

@max_length = 0
@b_set = primes_to(1000)

(-1000 .. 1000).each do |a|
  @b_set.each do |b|
    l = primes_length(a, b)
    if(l > @max_length)
      @max_length = l

      puts [a, b, l, a*b].join(" ")
    end
  end
end

require 'lib'

@primes = primes_to(3000)

a = (1..7).to_a

begin
  p a if a.digits_to_num.prime?(@primes)
end while a.next_perm

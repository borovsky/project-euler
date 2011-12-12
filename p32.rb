require 'lib'

a = (1..9).to_a
@r = []

def test(s, m1, m2)

  if s == m1 * m2
    @r << s
    puts [s, m1, m2].join(" ")
  end
end

begin
  s = a[0, 4].digits_to_num
  m1 = a[4, 2].digits_to_num
  m2 = a[6, 3].digits_to_num

  test(s, m1, m2)

  m1 = a[4, 1].digits_to_num
  m2 = a[5, 4].digits_to_num
  test(s, m1, m2)
end while a.next_perm

puts @r.uniq
puts @r.uniq.sum

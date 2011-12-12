require 'lib'

r = 0

(1..9999).each do|i|
  s = []
  m = 1
  while s.length <10
    s += (i * m).digits
    if s.pandigital?
      num = s.digits_to_num
      if(r < num)
        r = num
        puts num
      end
    end
    m += 1
  end
end

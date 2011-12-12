require 'lib'

END_LIST = 28123

def gen_abundant_numbers
  puts "Calculating abundant numbers"
  @nums = []
  (1..END_LIST).each {|i|
    @nums << i if proper_divisors(i).sum > i
  }
  puts "done"
end

gen_abundant_numbers

def sum_of_abundant_numbers?(n)
  len = @nums.length
  l = 0
  r = @nums.bsearch(n)
  while(true)
    l += 1 while(@nums[l] + @nums[r] < n and l <= r)
    r -= 1 while(@nums[l] + @nums[r] > n and r >= l)
    return true if @nums[l] + @nums[r] == n
    return false if r <= l
    #puts "#{l} #{r}"
  end

end

s = 0

puts sum_of_abundant_numbers?(30)


(1..END_LIST).each do |i|
  s += i unless sum_of_abundant_numbers?(i)
  puts i if i % 100 == 0
end

puts s

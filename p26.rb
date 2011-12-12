def get_recurr_length(n)
  return 0 if 10**10 % n == 0
  i = 1
  v = Hash.new
  v[1] = 0
  while true
    r = 10 ** i % n
    return i - v[r] if(v[r])
    v[r] = i
    i += 1
  end
  
end

@max_len = 0

(2..999).each {|i| 
  l = get_recurr_length(i)
  if l > @max_len
    @max_len = l
    puts "#{i} #{l}"
  end
}

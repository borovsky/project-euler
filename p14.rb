SIZE = 20

@data = Array.new(SIZE + 1)
@data = @data.map {|o| Array.new(SIZE + 1)}
@data[0][0] = 1


def calc(x, y)
  return 0 if x<0 or y<0
  return @data[y][x] if @data[y][x]

  res = calc(x-1, y) + calc(x, y-1)
  @data[y][x] = res
  res
end

puts calc(SIZE, SIZE)

require './lib.rb'

def pm(m)
  m.each do |l|
    printf "["
    l.each {|i| printf("%5d", i)}
    printf "]\n"
  end
end

def calc(matrix, price, i, j)
  if i == 0 && j == 0
    price[i][j] =  matrix[i][j]
    return 0
  end
  v = []
  v << price[i-1][j] if i > 0
  v << price[i][j-1] if j > 0
  v << price[i+1][j] if i + 1 < matrix.length
  v << price[i][j+1] if j + 1 < matrix[0].length
  new = v.min + matrix[i][j]
  old = price[i][j]
  price[i][j] = new
  new == old ? 0 : 1
end

def len(matrix)
  price = matrix.map{|l| [1_000_000] * l.length}
  m = 0
  changed = 1
  it = 0
  0.upto(matrix[0].length-1).each do |j|
    0.upto(matrix.length-1) do |i|
      calc(matrix, price, i, j)
    end
  end
  while changed  > 0 do
    changed = 0
    0.upto(matrix[0].length-1).each do |j|
      0.upto(matrix.length-1) do |i|
        changed += calc(matrix, price, i, j)
      end
    end
    (matrix.length-1).downto(0) do |i|
      (matrix[0].length-1).downto(0).each do |j|
        changed += calc(matrix, price, i, j)
      end
    end
    0.upto(matrix[0].length-1).each do |j|
      (matrix.length-1).downto(0) do |i|
        changed += calc(matrix, price, i, j)
      end
    end
    0.upto(matrix.length-1) do |i|
      (matrix[0].length-1).downto(0).each do |j|
        changed += calc(matrix, price, i, j)
      end
    end
    it+=1
    p [it, changed] if it % 1000 == 0
  end
  price.map(&:last).last
end

def load(file)
  matrix = []
  File.open(file) do |f|
    f.each_line do |l|
      ss = l.split(",").map(&:to_i)
      matrix << ss if ss.length > 0
    end
  end
  matrix
end

assert_eq 2297, len([[131,673,234,103,18],
                     [201,96,342,965,150],
                     [630,803,746,422,111],
                     [537,699,497,121,956],
                     [805,732,524,37,331]])

p len(load("matrix.txt"))

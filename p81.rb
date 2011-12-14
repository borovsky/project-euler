require './lib.rb'

def len(matrix)
  price = matrix.map{|l| [0] * l.length}
  m = 0
  (0...matrix.length).each do |i|
    (0...matrix[i].length).each do |j|
      if(i == 0 && j == 0)
        price[i][j] = matrix[i][j]
      else
        v = []
        v << price[i-1][j] if i > 0
        v << price[i][j-1] if j > 0
        m = price[i][j] = v.min + matrix[i][j]
      end
    end
  end
  m
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

assert_eq 2427, len([[131,673,234,103,18],
                     [201,96,342,965,150],
                     [630,803,746,422,111],
                     [537,699,497,121,956],
                     [805,732,524,37,331]])

p len(load("matrix.txt"))

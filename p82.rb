require './lib.rb'

def pm(m)
  m.each do |l|
    printf "["
    l.each {|i| printf("%5d", i)}
    printf "]\n"
  end
end

def len(matrix)
  price = matrix.map{|l| [0] * l.length}
  m = 0
  0.upto(matrix[0].length-1).each do |j|
    0.upto(matrix.length-1) do |i|
      if(j == 0)
        price[i][j] = matrix[i][j]
      else
        v = []
        v << price[i-1][j] if i > 0
        v << price[i][j-1] if j > 0
        price[i][j] = v.min + matrix[i][j]
      end
    end
    (matrix.length-1).downto(0) do |i|
      if(j == 0)
        price[i][j] = matrix[i][j]
      else
        v = []
        v << price[i][j]
        v << price[i+1][j] + matrix[i][j] if i + 1 < matrix.length
        price[i][j] = v.min
      end
    end
  end
  price.map(&:last).min
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

assert_eq 994, len([[131,673,234,103,18],
                     [201,96,342,965,150],
                     [630,803,746,422,111],
                     [537,699,497,121,956],
                     [805,732,524,37,331]])

p len(load("matrix.txt"))

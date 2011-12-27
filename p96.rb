require './lib.rb'

# Uses some methods from http://www.sudocue.net/guide.php

class Array
  def ==(b)
    if self.length == b.length
      self.each_with_index do |v, i|
        return false unless v == b[i]
      end
      true
    else
      false
    end
  end
end

def calc_possible_vals(grid, i, j)
  return [] if grid[i][j] != 0
  could = (1..9).to_a

  #process rows and columns
  0.upto(8) do |k|
    could.delete(grid[i][k])
    could.delete(grid[k][j])
  end
  # process square
  ii = i - i % 3
  jj = j - j % 3

  0.upto(2) do |k|
    0.upto(2) do |l|
      could.delete(grid[ii + k][jj + l])
    end
  end

  could
end


class Grid
  attr_accessor :grid
  attr_writer :possible_vals

  def initialize(grid, pv = nil)
    @grid = grid
    if pv
      @possible_vals = pv
    else
      @possible_vals = grid.map {|r| r.map {|c| []}}
      grid.each_with_index do |r, i|
        r.each_with_index do |c, j|
          @possible_vals[i][j] = calc_possible_vals(grid, i, j)
        end
      end
    end
    @pair_processed = {}
  end

  def dup
    pv = @possible_vals.map{|r| r.map {|c| c.dup}}
    Grid.new(@grid.map {|r| r.dup}, pv)
  end

  def [](i, j)
    @grid[i][j]
  end

  def []=(i, j, v)
    @grid[i][j] = v
    0.upto(8) do |k|
      @possible_vals[i][k].delete(v)
      @possible_vals[k][j].delete(v)
      @possible_vals[i - i % 3 + (k / 3).to_i ][j - j % 3 + k % 3].delete(v)
    end
  end

  def possible_vals(i, j)
    @possible_vals[i][j]
  end

  def set_possible_vals(i, j, v)
    @possible_vals[i][j] = v
  end

  def pair_processed?(i, j)
    @pair_processed[[i, j]]
  end

  def pair_processed(i, j)
    @pair_processed[[i, j]] = true
  end
  
  def print
    @grid.each {|l| p l}
  end

  def print_pv
    @possible_vals.each {|l| p l}
  end

  def solved?
    grid.each do |l|
      l.each do |i|
        return false if i == 0
      end
    end
    true
  end

  def each_cell_with_index
    0.upto(8) do |i|
      0.upto(8) do |j|
        yield @grid[i][j], @possible_vals[i][j], i, j
      end
    end
  end

  def validate
    0.upto(8) do |i|
      r = (1..9).to_a
      c = (1..9).to_a
      s = (1..9).to_a

      0.upto(8) do |j|
        r.delete @grid[i][j]
        c.delete @grid[j][i]
        s.delete @grid[i.div(3) * 3 + j.div(3)][(i % 3) * 3 + j % 3]
      end
      unless r.empty? && c.empty? && s.empty?
        self.print
        raise "Validation error at #{i}: #{r}, #{c}, #{s}"
      end
    end
  end

  def each_in_field(i, j)
    0.upto(8) do |k|
      x = i - i % 3 + k.div(3)
      y = j - j % 3 + k % 3
      yield k, x, y
    end
  end

  def each_unsolved
    0.upto(8) do |i|
      0.upto(8) do |j|
        if self[i, j] == 0
          yield i, j
        end
      end
    end
  end
end


def failed(msg, grid)
  raise msg
end

def reduce_naked_single(grid, i, j)
  vals = grid.possible_vals(i, j)
  if vals.length == 0
    failed("no options for (#{i}, #{j})", grid)
  end
  if vals.length == 1
    grid[i, j] = vals.first
    return true
  end
end

def reduce_hidden_single(grid, i, j)
  vals = grid.possible_vals(i, j)
  # analyze row, column, square for unique cell
  l1 = {}
  l2 = {}
  l3 = {}

  grid.each_in_field(i, j) do |k, x, y|
    grid.possible_vals(i, k).each {|v| l1[v] = true} if k != j and grid[i, k] == 0
    grid.possible_vals(k, j).each {|v| l2[v] = true} if k != i and grid[k, j] == 0
    grid.possible_vals(x, y).each {|v| l3[v] = true} if x != i or y != j and grid[x, y] == 0
  end
  n1 = []
  n2 = []
  n3 = []
  vals.each do |v|
    n1 << v unless l1[v]
    n2 << v unless l2[v]
    n3 << v unless l3[v]
  end
  if n1.length == 1
    grid.set_possible_vals(i, j, n1)
  elsif n2.length == 1
    grid.set_possible_vals(i, j, n2)
  elsif n3.length == 1
    grid.set_possible_vals(i, j, n3)
  else
    return false
  end
  true
end

def find_naked_pairs(grid, i, j)
  return false if grid.pair_processed?(i, j)
  v = grid.possible_vals(i, j)
  if v.length == 2
    grid.each_in_field(i, j) do |k, x, y|
      if k != j && grid.possible_vals(i, k) == v
        return [i, k]
      elsif k != i && grid.possible_vals(k, j) == v
        return [k, j]
      elsif (i != x or j != y) and grid.possible_vals(x, y) == v
        return [x, y]
      end
    end
  end
  false
end

def reduce_naked_pairs(grid, i, j)
  found = false
  pair = find_naked_pairs(grid, i, j)
  v = grid.possible_vals(i, j)

  if pair
    found = true
    grid.pair_processed(i, j)
    grid.pair_processed(*pair)

    if i == pair.first
      0.upto(8) do |k|
        if j != k and pair.last != k
          nv = grid.possible_vals(i, k)
          v.each {|e| nv.delete e }
          grid.set_possible_vals(i, k, nv)
        end
      end
    end
    if j == pair.last
      0.upto(8) do |k|
        if i != k and pair.first != k
          nv = grid.possible_vals(k, j)
          v.each {|e| nv.delete e }
          grid.set_possible_vals(k, j, nv)
        end
      end
    end
    if i.div(3) == pair.first.div(3) && j.div(3) == pair.last.div(3)
      grid.each_in_field(i, j) do |k, x, y|
        if (i != x or j != y) and (x != pair.first or y != pair.last)
          nv = grid.possible_vals(x, y)
          v.each {|e| nv.delete e }
          grid.set_possible_vals(x, y, nv)
        end
      end
    end
  end

  found
end

def reduce(grid)
  any_change = true

  while any_change do
    any_change = false
    changed = true
    while changed
      changed = false
      grid.each_unsolved do |i, j|
        changed ||= reduce_naked_single(grid, i, j)
        changed ||= reduce_hidden_single(grid, i, j) if grid[i, j] == 0
      end
    end

    grid.each_unsolved do |i, j|
      changed ||= reduce_naked_pairs(grid, i, j)
    end
    any_change = changed
  end
end

def solve_sudoku(grid, level = 1, top = false)
  reduce(grid)

  if grid.solved?
    grid
  else
    # Try to select one variant
    grid.each_cell_with_index do |cell, pv, i, j|
      printf(".") if top
      if grid[i, j] == 0
        pv.each do |v|
          begin
            grc = grid.dup
            grc[i,j] = v
            ng = solve_sudoku(grc, level + 1)
            return ng if ng
          rescue RuntimeError
          end
        end
      end
    end if level < 3
    false
  end
end

s = 0
count = 0
solved = 0
res = 0
File.open("sudoku.txt") do |f|
  1.upto(50) do
    count +=1
    name = f.readline
    grid = []
    1.upto(9) do
      l = f.readline
      grid << l.strip.each_char.to_a.map(&:to_i)
    end
    puts
    puts name
    g = solve_sudoku(Grid.new(grid), 1, true)
    if g
      g.validate
      solved += 1
      res += g[0, 0] * 100 + g[0, 1] * 10 + g[0, 2]
    else
      puts "UNSOLVED"
    end
  end
end

puts "Solved #{solved} / #{count}: #{res}"

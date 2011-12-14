require './lib.rb'


def check_perm(perm, build)
  count = build.length
  s = build[0].inject(0) {|s, i| s + perm[i]}
  (1...count).each do |b|
    return false unless s == build[b].inject(0) {|s, i| s + perm[i] }
  end
  return true
end

def calc_magic(set, count)
  a = set.to_a
  build = build_indexes(count)

  r = []

  while a = a.next_perm
    if check_perm(a, build)
      r << a.dup
      p r.length
    end
  end
  r
end

def build_indexes(count)
  a = Array.new(count)
  (1..count).each do |i|
    a[i - 1] = [i - 1, i + count - 1, (i % count) + count]
  end
  a
end

def to_build_string(build, indexes)
  count = indexes.length
  mi = 100
  m = 100

  indexes.each_with_index do |l, i|
    m, mi = build[l.first], i if build[l.first] < m
  end

  r = []
  (0...count).each do |i|
    idx = indexes[(i + mi) % count]
    r += [build[idx[0]], build[idx[1]], build[idx[2]]]
  end
  r.map(&:to_s).join("")
end

def builds(size, ans_len)
  a = calc_magic(1..(size * 2), size)
  build = build_indexes(size)
  n = a.map {|a| to_build_string(a, build)}.sort.uniq
  n.find_all{|a| a.length == ans_len}
end

assert_eq [[0, 3, 4], [1, 4, 5], [2, 5, 3]], build_indexes(3)
assert_eq "423531612", to_build_string([6, 4, 5, 1, 2, 3], build_indexes(3))
assert_eq true, check_perm([3, 4, 5, 1, 2, 0], build_indexes(3))

p builds(3, 9)
p builds(5, 16)

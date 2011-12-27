require './lib.rb'


def load_anagrams
  words = []
  File.open("words.txt") do |f|
    while !f.eof?
      l = f.read
      l = l.split(",")
      l.map! {|w| w.gsub('"', '')}
      words += l
    end
  end

  anagrams_pre = Hash.new {[]}

  words.each do |w|
    b = w.chars.sort.join("")
    anagrams_pre[b] += [w]
  end

  #Filter that occurs only once
  anagrams = {}
  anagrams_pre.each do |k, v|
    anagrams[k] = v if v.length > 1
  end
  anagrams
end


def match?(sq, ana)
  h = {}
  h2 = {}
  sq.chars.each_with_index do |c, idx|
    if !h[c]
      h[c] = ana[idx]
      h2[ana[idx]] = c
    elsif h[c] != ana[idx]
      return false
    end
  end
  h2
end

def map_ana(ana, mp)
  ana.chars.map {|c| mp[c]}.join("")
end

def matches(sq, anagrams, squares_map)
  ms = []
  sqs = sq.to_s
  ana = anagrams[sqs.length]
  ana.each do |al|
    if mp = al.find {|a| match?(sqs, a)}
      mp = match?(sqs, mp)
      at = []
      al.each do |a|
        st = map_ana(a, mp)
        if squares_map[st]
          at << st
        end
      end
      ms += at if at.length > 1
    end
  end
  ms
end

anagrams = load_anagrams
ana_len = Hash.new {[]}

anagrams.each do |k, v|
  ana_len[k.length] += [v]
end
max_sq = 0

squares = (4..32_000).map{|i| i * i}.find_all{|i| i >= 10 && i <= 999_999_999}
squares_map  = {}
squares.each {|s| squares_map[s.to_s] = true}

r = []
squares.each do |s|
  m = matches(s, ana_len, squares_map)
  r += m
  p m if m.length > 0
end

p r.map(&:to_i).sort.last

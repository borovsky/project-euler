data = File.open("triangle.txt").read

@data =  data.split("\n").map{|l| l.split(" ").map{|j| j.to_i}}

line = @data[-1]

(@data.length-2).downto(0) do |l|
  n = @data[l].dup
  @data[l].each_with_index do|e, i|
    n[i] = e + [line[i], line[i+1]].max
  end
  line = n
end

p line

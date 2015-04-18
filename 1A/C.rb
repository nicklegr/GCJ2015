require 'pp'

def ppd(*arg)
  if $DEBUG
    pp(*arg)
  end
end

def putsd(*arg)
  if $DEBUG
    puts(*arg)
  end
end

def parr(arr)
  puts arr.join(" ")
end

def parrd(arr)
  putsd arr.join(" ")
end

def ri
  readline.to_i
end

def ris
  readline.split.map do |e| e.to_i end
end

def rs
  readline.chomp
end

def rss
  readline.chomp.split
end

def rf
  readline.to_f
end

def rfs
  readline.split.map do |e| e.to_f end
end

def rws(count)
  words = []
  count.times do
    words << readline.chomp
  end
  words
end

class P
  def initialize(x, y)
    @x = x
    @y = y
  end

  def to_s
    "(#{@x}, #{@y})"
  end

  attr_accessor :x, :y
end

def gcd(a, b)
  while b != 0 do
    a, b = b, a % b
  end
  a
end

def on_line(ps, cur, test)
  offset = P.new(ps[test].x - ps[cur].x, ps[test].y - ps[cur].y)

  offset.x /= gcd(offset.x, offset.y)
  offset.y /= gcd(offset.x, offset.y)

  ps.each_with_index do |e, i|
    next if i == cur || i == test
    offset2 = P.new(e.x - ps[cur].x, e.y - ps[cur].y)
    offset2.x /= gcd(offset2.x, offset2.y)
    offset2.y /= gcd(offset2.x, offset2.y)

    if offset.x.abs == offset2.x.abs &&
      offset.y.abs == offset2.y.abs
      return true
    end
  end

  return false
end

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  # write your code here
  n = ri
  ps = []
  n.times do
    is = ris
    ps << P.new(is[0], is[1])
  end

ppd n
parrd ps

  puts "Case ##{case_index}:"

  for cur in 0...n
    p = ps[cur]
    cut = 0

    ps.each_with_index do |e, test|
      if p.x < e.x
        if !on_line(ps, cur, test)
          cut += 1
          next
        end
      end
      if e.x < p.x
        if !on_line(ps, cur, test)
          cut += 1
          next
        end
      end

      if p.y < e.y
        if !on_line(ps, cur, test)
          cut += 1
          next
        end
      end
      if e.y < p.y
        if !on_line(ps, cur, test)
          cut += 1
          next
        end
      end
    end

    puts cut
  end


  # progress
  trigger = 
    if cases >= 10
      case_index % (cases / 10) == 0
    else
      true
    end

  if trigger
    STDERR.puts("case #{case_index} / #{cases}, time: #{Time.now - t_start} s")
  end
end

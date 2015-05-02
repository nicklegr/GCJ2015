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

def bitcount(bits)
  bits = (bits & 0x55555555) + (bits >> 1 & 0x55555555)
  bits = (bits & 0x33333333) + (bits >> 2 & 0x33333333)
  bits = (bits & 0x0f0f0f0f) + (bits >> 4 & 0x0f0f0f0f)
  bits = (bits & 0x00ff00ff) + (bits >> 8 & 0x00ff00ff)
  return (bits & 0x0000ffff) + (bits >>16 & 0x0000ffff)
end

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  # write your code here
  r, c, n = ris

  min = 10000000
  for bits in 0...2**(r*c)
    next if bitcount(bits) != n

    unhappy = 0
    for j in 0...r
      b = bits >> j * c
      for k in 0...c-1
        unhappy += 1 if (((b>>k)&1) & ((b>>(k+1))&1)) != 0
      end
    end

    for j in 0...r-1
      b = bits >> j * c
      for k in 0...c
        unhappy += 1 if (((b>>k)&1) & ((b>>(k+c))&1)) != 0
      end
    end

    if unhappy < min
      min = unhappy
    end
  end

  puts "Case ##{case_index}: #{min}"

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

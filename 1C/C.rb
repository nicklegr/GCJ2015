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
  c, d, v = ris
  ds = ris
  added_count = 0

  loop do
parrd ds
    ok = 0

    for i in 0...(1 << ds.size)
      total = 0
      for j in 0...ds.size
        total += ds[j] if ((i >> j) & 1) != 0
      end
      ok |= (1 << total)
    end

    ok &= ((1 << (v+1)) - 1)

    break if bitcount(ok) == v+1 # zero

ppd ok.to_s(2)
    mask = 2
    added = false
    for i in 1..v
      unless (ok & mask) != 0
        ds << i
        added = true
        added_count += 1
        break
      end
      mask <<= 1
    end

    raise unless added
  end

  puts "Case ##{case_index}: #{added_count}"

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

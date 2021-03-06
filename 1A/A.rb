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

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  # write your code here
  n = ri
  arr = ris

  diffs = []
  for i in 0..arr.size-2
    if arr[i] >= arr[i+1]
      diffs << arr[i] - arr[i+1]
    else
      diffs << 0
    end
  end
parrd diffs
  sum = diffs.reduce(:+)

  max_rate = diffs.max

  sum2 = 0
  for i in 0..arr.size-2
    sum2 += [arr[i], max_rate].min
  end

  puts "Case ##{case_index}: #{sum} #{sum2}"

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

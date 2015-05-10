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

def check(str, target)
  count = 0
  p = str.size - target.size
  l = target.size
  for i in 0..p
    count += 1 if str[i, l] == target
  end

  count
end

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  k, l, s = ris
  keyboard = rs
  target = rs

  c_total = 0
  c_max = 0
  try = 0
  keyboard.each_char.to_a.repeated_permutation(s) do |str|
    str = str.join("")
    c = check(str, target)
# putsd "#{str} #{c}" if c != 0
    c_total += c
    if c_max < c
      c_max = c
    end
    try += 1
  end

  expected = c_total.to_f / try
  answer = c_max.to_f - expected

  puts "Case ##{case_index}: #{answer}"

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

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
  for i in 1 .. count
    words << readline.chomp
  end
  words
end

def max_index(arr)
  max = 0
  max_i = -1
  arr.each_with_index do |e, i|
    if e > max
      max_i = i
      max = e
    end
  end
  max_i
end

$min_turn = 99999

def dfs(turn, arr)
  max = arr.max
  exp_turn = turn + max
  if exp_turn < $min_turn
# puts "#{exp_turn}t: " + arr.join(' ')
    $min_turn = exp_turn
  end

  return if max == 1

  # eat
  n = arr.map do |e| e - 1 end
  dfs(turn + 1, n)

  # divide
  max_i = max_index(arr)
  v = arr[max_i]

  a = b = 0
  if v & 1 == 1
    a = v / 2
    b = v / 2 + 1
  else
    a = b = v / 2
  end

  n = arr.dup
  n[max_i] = a
  n << b
  dfs(turn + 1, n)
end

# main
t_start = Time.now

# 問題に応じて
cases = readline().to_i

(1 .. cases).each do |case_index|
  $min_turn = 99999

  ri
  arr = ris

  dfs(0, arr)

  puts "Case ##{case_index}: #{$min_turn}"

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

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

def max(a, b)
  if a < b
    b
  else
    a
  end
end

$min_turn = 99999
$min_arr = []
$already = {}

def dfs(turn, arr)
  arr.sort!
  return if $already[arr.hash]
  $already[arr.hash] = 1

  max = arr.max
  exp_turn = turn + max
#puts "#{exp_turn}t: " + arr.join(' ')
  if exp_turn < $min_turn
#puts "#{exp_turn}t: " + arr.join(' ')
    $min_turn = exp_turn
    $min_arr = arr
  end

  return if max == 1

  # eat
  # n = arr.map do |e| max(e - 1, 0) end
  # dfs(turn + 1, n)

  # divide
  max_i = max_index(arr)
  v = arr[max_i]
  return if v <= 3

  for i in 1..v-1
    a = i
    b = v - i

    n = arr.dup
    n[max_i] = a
    n << b
    dfs(turn + 1, n)
  end
end

# main
t_start = Time.now

for i in 0..50
  $min_turn = 99999
  $min_arr = []
  $already = {}
  dfs(0, [i])
  puts "#{i} => #{$min_turn}t: #{$min_arr.join(' ')}"
end


__END__

# 問題に応じて
cases = readline().to_i

(1 .. cases).each do |case_index|
  $min_turn = 99999
  $already = {}

  ri
  arr = ris

#puts arr.join(" ")
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

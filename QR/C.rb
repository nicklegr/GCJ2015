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


CONV = {
  "1" => 0,
  "i" => 1,
  "j" => 2,
  "k" => 3,
  "-1" => 4,
  "-i" => 5,
  "-j" => 6,
  "-k" => 7,
}

TBL = [
  [0,1,2,3, 4,5,6,7],
  [1,4,3,6, 5,0,7,2],
  [2,7,4,1, 6,3,0,5],
  [3,2,5,4, 7,6,1,0],

  [4,5,6,7, 0,1,2,3], # -1 * X
  [5,0,7,2, 1,4,3,6], # -i * X
  [6,3,0,5, 2,7,4,1], # -j * X
  [7,6,1,0, 3,2,5,4], # -k * X
]

$found = false

def conv(str)
  ret = []
  str.each_char do |c|
    ret << CONV[c]
  end
  ret
end

def find_i(arr, b, e)
# putsd "#{arr.join('')} #{b} #{e}"
# pp b, e
  return if b > e

  v = arr[b]
  loop do
    if v == 1
      find_k(arr, b+1, e)
      return if $found
    end

    b += 1
    break if b > e
# puts "#{v} #{arr[b]}"
    v = TBL[v][arr[b]]
  end
end

def find_k(arr, b, e)
# putsd "#{arr.join('')} #{b} #{e}"
  return if b > e

  v = arr[e]
  loop do
    if v == 3
      is_j(arr, b, e-1)
      return if $found
    end

    e -= 1
    break if b > e
    v = TBL[arr[e]][v]
  end
end

def is_j(arr, b, e)
# putsd "#{arr.join('')} #{b} #{e}"
  return if b > e

  v = arr[b]

  loop do
    b += 1
    break if b > e
    v = TBL[v][arr[b]]
  end

  if v == 2
    $found = true
  end
end

# main
t_start = Time.now

# 問題に応じて
cases = readline().to_i

(1 .. cases).each do |case_index|
  l, x = ris
  str = rs

  str *= x

  $found = false
  arr = conv(str)
  find_i(arr, 0, arr.size-1)

  puts "Case ##{case_index}: #{$found ? 'YES' : 'NO'}"

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

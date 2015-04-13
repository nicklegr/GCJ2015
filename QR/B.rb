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

# 問題に応じて
cases = readline().to_i

(1 .. cases).each do |case_index|
  ri
  arr = ris

  # ds[i] == i枚のパンケーキがある皿の数
  ds = Array.new(1001, 0)

puts "---"
puts arr.join(" ")
  arr.each do |e|
    ds[e] += 1
  end

  min_turn = 9999
  turn = 0
  last_max_i = 1000
  loop do
    max_i = -1
    last_max_i.downto(0) do |i|
      if ds[i] != 0
        last_max_i = max_i = i
        break
      end
    end

    raise if max_i == -1

    if turn + max_i < min_turn
      min_turn = turn + max_i
    end

    # 3枚以下は分割不要
    break if max_i <= 3

    # 一番枚数が多い皿がボトルネックなので減らす
    count = ds[max_i]
    v = max_i

    best_factor = nil
    best_turn = nil

    31.downto(2) do |factor|
      if v >= factor * factor
        # factor等分する
        divided = v / factor
        mod = v % factor

        t = divided
        t += 1 if mod != 0

        t += factor - 1
        t += 1 if mod != 0

        if !best_turn || t <= best_turn
          best_turn = t

          if best_factor
            best_factor = factor if factor < best_factor
          else
            best_factor = factor
          end
        end
      end
    end

    raise unless best_factor

    # factor等分する
    divided = v / best_factor
    mod = v % best_factor
puts ds[0..30].join(" ")
puts "best_factor:#{best_factor}, divided:#{divided}, mod:#{mod}"
    ds[best_factor] += divided * count
    ds[mod] += count if mod != 0
    ds[max_i] = 0

    turn += divided * count
    turn -= count if mod == 0
puts "turn: #{turn}"
  end

puts ds[0..30].join(" ")
  puts "Case ##{case_index}: #{min_turn}"

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

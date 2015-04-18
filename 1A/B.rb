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

def gcd(a, b)
  while b != 0 do
    a, b = b, a % b
  end
  a
end

def lcm(a, b)
  a * b / gcd(a, b)
end

def lcm_arr(arr)
  arr.reduce(:lcm)
end

def solve(b, n, m)
  lcm_v = lcm_arr(m)
  ended = 0

ppd b, n
parrd m

  m.each do |e|
    raise if lcm_v % e != 0
    ended += lcm_v / e
  end

ppd ended

  if n <= ended
    ended = 0
  else
    n = n % ended
    ended = 0
  end

ppd ended, n

  return b if n == 0

  wait = Array.new(b, 0)

  loop do
    for i in 0...b
      if wait[i] == 0
        wait[i] = m[i]
        ended += 1
        if ended == n
          return i + 1
        end
      end
    end
    wait.map! do |e|
      raise if e == 0
      e - 1
    end
  end
end

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  # write your code here
  b, n = ris
  m = ris

  answer = solve(b, n, m)

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

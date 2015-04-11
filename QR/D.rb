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

# main
t_start = Time.now

# 問題に応じて
cases = readline().to_i

(1 .. cases).each do |case_index|
  # readline().chomp
  # readline().split
  x, r, c = ris

  w = h = 0
  if r < c
    w = r
    h = c
  else
    w = c
    h = r
  end

  answer = nil

  if x > r && x > c
    answer = "RICHARD"
  elsif (r*c) % x != 0
    answer = "RICHARD"
  else
    answer =
      case x
      when 1
        "GABRIEL"
      when 2
        if (w == 1 && h == 3) || (w == 3 && h == 3)
          "RICHARD"
        else
          "GABRIEL"
        end
      when 3
        if (w == 4 && h == 4) || (w == 1 && h == 3)
          "RICHARD"
        else
          "GABRIEL"
        end
      when 4
        if w <= 2 && h == 4
          "RICHARD"
        else
          "GABRIEL"
        end
      end
  end

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

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

def solve(n)
  return n if n <= 19

  v = 1
  c = 1
  while v != n
    if v <= 10
      c += 11 - v
      v = 11
      next
    end

    # 桁を増やす
    # 19 -> 91
    # 109 -> 901
    # 1009 -> 9001 etc
    len_v = v.to_s.size
    len_n = n.to_s.size

    if len_v < len_n
      # v -> 19
      target = "1" + ("0" * (len_v-2)) + "9"
      target = target.to_i

      c += target - v
      v = target

      # 19 -> 91
      c += 1
      v = v.to_s.reverse.to_i

      # 91 -> 100
      target = "1" + ("0" * len_v)
      target = target.to_i

      c += target - v
      v = target
    else
# ppd c
      str_n = n.to_s
      rev_v = "1" + ("0" * (len_n-1))
      best = nil
      best_cost = nil
      for i in 0...len_n
# ppd actual_rev_v

        actual_rev_v = nil
        for k in 0..9
          rev_v[len_n-1-i] = k.to_s
          actual_rev_v = rev_v.gsub(/^0+/, '')
          next if actual_rev_v.reverse.to_i > n

          cost = (actual_rev_v.to_i - v) + (n - actual_rev_v.reverse.to_i) + 1
          if !best_cost || cost < best_cost
            best = actual_rev_v.to_i
            best_cost = cost
          end
# putsd "#{actual_rev_v} #{actual_rev_v.reverse}, #{n}"
        end
      end

      return c + best_cost
    end
  end

  c
end

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  # write your code here
  n = ri

  puts "Case ##{case_index}: #{solve(n)}"

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

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

class Integer
  def combination(k)
    self.factorial/(k.factorial*(self-k).factorial)
  end

  def permutation(k)
    self.factorial/(self-k).factorial
  end

  def factorial
    return 1 if self == 0
    (1..self).inject(:*)
  end
end

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  k, l, s = ris
  keyboard = rs
  target = rs

  target_prob = 1
  target.each_char do |c|
    ok_keys = keyboard.scan(c).size
    target_prob *= ok_keys.to_f / keyboard.size
  end

  total_pat = 0
  max_count = 0

  # non overlap
  str = target
  target_count = 1
  while str.size <= s
putsd str
    left = s - str.size

    pat = (target_count + left).combination(target_count)
ppd pat
    total_pat += pat
ppd prob

    str += target
    target_count += 1
    max_count = target_count if max_count < target_count
  end

  # overlap
  # ABA => 2, 1
  overlap_count = nil
  for i in 1..target.size
    beg = target[0, i]
    overlap = target.rindex(beg)
    if overlap
      overlap_count = i
    else
      break
    end
  end

  if overlap_count != target.size
    str = target
    target_count = 1
    while str.size <= s
      left = s - str.size

      pat = (1 + left).combination(1)

      prob = (target_prob ** target_count) * pat
      total_prob += prob

      str += target[overlap_count, 999999]
      target_count += 1
      max_count = target_count if max_count < target_count
    end
  end

  expected = s.permutation(s) * total_prob
  answer = max_count.to_f - expected

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

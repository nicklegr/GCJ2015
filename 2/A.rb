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

def check_loop(m, r, c, goods)
  # すでにループになってるやつ
  bads = []
  for y in 0...r
    for x in 0...c
      next if m[y][x] == '.'

      path = {}
      px = x
      py = y
      dx = 0
      dy = 0
      last = [y, x]
      fail = false
      loop do
        break if goods[py][px] == 1
        break if path.key?([py, px])

        case m[py][px]
        when '<'
          dx = -1
          dy = 0
        when '>'
          dx = 1
          dy = 0
        when '^'
          dx = 0
          dy = -1
        when 'v'
          dx = 0
          dy = 1
        end
        # .はそのまま

        if m[py][px] != '.'
          path[[py, px]] = 1
          last = [py, px]
        end

        px += dx
        py += dy

        if px < 0 || px >= c || py < 0 || py >= r
          bads << last
          fail = true
          break
        end
      end

      if !fail
        path.keys.each do |k|
          goods[k[0]][k[1]] = 1
        end
      end
    end
  end

  bads
end

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  r, c = ris
  m = rws(r)

m.each do |l|
  putsd l
end


  changed = 0

  goods = Array.new(r) do |i|
    Array.new(c) do |j|
      0
    end
  end

ppd goods

  still_bad_count = -1
  still_bads = []

  while still_bads.size != still_bad_count
    still_bad_count = still_bads.size
    still_bads = []

    # ループに突っ込ませるか、自分の方向いてる矢印に向ける
    bads = check_loop(m, r, c, goods)
    bads.sort!
    bads.uniq!
    ppd bads

    bads.each do |b|
      ok = false
      sy, sx = b[0], b[1]

      py, px = b[0], b[1]
      loop do
        px += 1
        break if (px < 0 || px >= c || py < 0 || py >= r)
        if goods[py][px] == 1 || m[py][px] == '<'
          m[sy][sx] = '>'
          changed += 1
          ok = true
          break
        end
        break if m[py][px] != '.' && m[py][px] != '<'
      end
      next if ok

      py, px = b[0], b[1]
      loop do
        px -= 1
        break if (px < 0 || px >= c || py < 0 || py >= r)
        if goods[py][px] == 1 || m[py][px] == '>'
          m[sy][sx] = '<'
          changed += 1
          ok = true
          break
        end
        break if m[py][px] != '.' && m[py][px] != '>'
      end
      next if ok

      py, px = b[0], b[1]
      loop do
        py += 1
        break if (px < 0 || px >= c || py < 0 || py >= r)
        if goods[py][px] == 1 || m[py][px] == '^'
          m[sy][sx] = 'v'
          changed += 1
          ok = true
          break
        end
        break if m[py][px] != '.' && m[py][px] != '^'
      end
      next if ok

      py, px = b[0], b[1]
      loop do
        py -= 1
        break if (px < 0 || px >= c || py < 0 || py >= r)
        if goods[py][px] == 1 || m[py][px] == 'v'
          m[sy][sx] = '^'
          changed += 1
          ok = true
          break
        end
        break if m[py][px] != '.' && m[py][px] != 'v'
      end
      next if ok

      still_bads << b
    end

    bads = still_bads
  end

m.each do |l|
  putsd l
end

ppd still_bads

  # でもダメなら最寄りの矢印を自分に向ける
  still2_bads = []
  still_bads.each do |b|
    sy, sx = b[0], b[1]
    py, px = b[0], b[1]
    ok = false

#puts sy, sx
    case m[sy][sx]
    when '<'
      px -= 1
      while !(px < 0 || px >= c || py < 0 || py >= r)
        if m[py][px] != '.'
          m[py][px] = '>'
          changed += 1
          ok = true
          break
        end
        px -= 1
      end
    when '>'
      px += 1
      while !(px < 0 || px >= c || py < 0 || py >= r)
        if m[py][px] != '.'
          m[py][px] = '<'
          changed += 1
          ok = true
          break
        end
        px += 1
      end
    when '^'
      py -= 1
      while !(px < 0 || px >= c || py < 0 || py >= r)
        if m[py][px] != '.'
          m[py][px] = 'v'
          changed += 1
          ok = true
          break
        end
        py -= 1
      end
    when 'v'
      py += 1
      while !(px < 0 || px >= c || py < 0 || py >= r)
        if m[py][px] != '.'
          m[py][px] = '^'
          changed += 1
          ok = true
          break
        end
        py += 1
      end
    end

    still2_bads << b if !ok
  end

ppd still2_bads

  impossible = false
  # まだダメなら自分と最寄りの矢印をペアに
  still2_bads.each do |b|
    ok = false
    sy, sx = b[0], b[1]
    next if m[sy][sx] == 'M'

    py, px = b[0], b[1]
    loop do
      px += 1
      break if (px < 0 || px >= c || py < 0 || py >= r)
      if m[py][px] != '.'
        m[sy][sx] = 'M'
        m[py][px] = 'M'
        changed += 2
        ok = true
        break
      end
    end
    next if ok

    py, px = b[0], b[1]
    loop do
      px -= 1
      break if (px < 0 || px >= c || py < 0 || py >= r)
      if m[py][px] != '.'
        m[sy][sx] = 'M'
        m[py][px] = 'M'
        changed += 2
        ok = true
        break
      end
    end
    next if ok

    py, px = b[0], b[1]
    loop do
      py += 1
      break if (px < 0 || px >= c || py < 0 || py >= r)
      if m[py][px] != '.'
        m[sy][sx] = 'M'
        m[py][px] = 'M'
        changed += 2
        ok = true
        break
      end
    end
    next if ok

    py, px = b[0], b[1]
    loop do
      py -= 1
      break if (px < 0 || px >= c || py < 0 || py >= r)
      if m[py][px] != '.'
        m[sy][sx] = 'M'
        m[py][px] = 'M'
        changed += 2
        ok = true
        break
      end
    end
    next if ok

    impossible = true
  end

m.each do |l|
  putsd l
end

  if impossible
    puts "Case ##{case_index}: IMPOSSIBLE"
  else
    puts "Case ##{case_index}: #{changed}"
  end

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

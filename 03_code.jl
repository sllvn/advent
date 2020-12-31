lines = readlines("./03_input.txt")
# lines = readlines("./03_sample.txt")

function count_trees(lines, slope)
  count = 0
  pos = [1, 1]

  while pos[2] <= length(lines)
    x, y = pos
    line_length = length(lines[y])

    if lines[y][mod1(x, line_length)] == '#'
      count += 1
    end
    pos = pos + slope
  end

  count
end

# count_trees(lines, [3, 1])

function check_slopes(lines, slopes)
  [count_trees(lines, slope) for slope in slopes]
end

slopes = [
  [1, 1],
  [3, 1],
  [5, 1],
  [7, 1],
  [1, 2]
]
reduce(*, check_slopes(lines, slopes))
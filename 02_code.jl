lines = readlines("./02_input.txt")

function parse_line(line)
  num, mid, password = split(line, " ")
  min, max = split(num, "-") |> n -> map(x -> parse(Int, x), n)
  char = mid[1]
  min, max, char, password
end

function is_valid_part1(def)
  min, max, char, password = def
  count = eachmatch(Regex(string(char)), password) |> collect |> length
  return min <= count <= max
end

function count_valid_part1(lines)
  length([line for line in lines if is_valid_part1(parse_line(line))])
end

# count_valid_part1(lines)

function is_valid_part2(def)
  min, max, char, password = def
  return xor(password[min] == char, password[max] == char)
end

function count_valid_part2(lines)
  length([line for line in lines if is_valid_part2(parse_line(line))])
end

# count_valid_part2(lines)
lines = readlines("./05_input.txt")

function make_reducer(increment_char)
  return function ((acc, pos), x)
    if x == increment_char
      (acc + 2^(pos-1), pos-1)
    else
      (acc, pos-1)
    end
  end
end

function parse_row(row::String)
  chars = split(row, "")
  row_number, _ = reduce(make_reducer("B"), chars, init=(0, 7))
  row_number
end

# parse_row("BFFFBBF") # 70
# parse_row("FFFBBBF") # 14
# parse_row("BBFFBBF") #102

function parse_seat(seat::String)
  chars = split(seat, "")
  seat_number, _ = reduce(make_reducer("R"), chars, init=(0, 3))
  seat_number
end

# parse_seat("RRR") # 7
# parse_seat("RLL") # 4

function parse_pass(id::String)
  row = parse_row(id[1:7])
  seat = parse_seat(id[8:10])
  row * 8 + seat
end

ids = map(p -> parse_pass(p), lines)
max_id = maximum(ids)
sorted_ids = sort(ids)

for (index, current) in enumerate(sorted_ids)
  next = index < length(sorted_ids) ? sorted_ids[index+1] : nothing
  if current + 1 != next
    println("gap at: ", current + 1)
  end
end

# next = iterate(sorted_ids)
# while next !== nothing
#     (i, state) = next
#     # body
#     next = iterate(sorted_ids, state)
# end

# for pass in lines
#   println(pass)
#   id = parse_pass(pass[1])
#   println(id)
# end
lines = readlines("./01_input.txt")
ns = map(x->parse(Int, x), lines)

function find_two(ns)
  for (i, x) in enumerate(ns), y in ns[i+1:end]
    if x + y == 2020
      print(x, " * ", y, " = ", x*y)
    end
  end
end

find_two(ns)

function find_three(ns)
  for (i, x) in enumerate(ns), (j, y) in enumerate(ns[i+1:end]), z in ns[j+1:end]
    if x + y + z == 2020
      print(x, " * ", y, " * ", z, " = ", x*y*z)
    end
  end
end

find_three(ns)
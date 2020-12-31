using Match

function read_passports(path)
  split(read(path, String), r"\n\n+")
end

function is_valid_height(raw_value)
  m = match(r"([0-9]*)([a-z]*)", raw_value)
  value, unit = m.captures
  @match unit begin
    "cm" => 150 <= parse(Int, value) <= 193
    "in" => 59 <= parse(Int, value) <= 76
    _ => false
  end
end

function is_valid_field(acc, (key, value))
  is_valid = @match strip(key) begin
    "byr" => 1920 <= parse(Int, value) <= 2002
    "iyr" => 2010 <= parse(Int, value) <= 2020
    "eyr" => 2020 <= parse(Int, value) <= 2030
    "hgt" => is_valid_height(value)
    "hcl" => !isnothing(match(r"#[0-9a-f]{6}$", value))
    "ecl" => value in Set(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"])
    "pid" => length(collect(eachmatch(r"[0-9]", value))) == 9
    _     => true
  end
  # println(key, ": ", value, " --- ", acc, ", ", is_valid)
  acc && is_valid
end

required_fields = Set(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]) # excluding "cid"

function is_valid(passport)
  keyvalues = split(strip(passport), r"\s") |> f -> map(x -> split(x, ":"), f) |> Dict
  diff = setdiff(required_fields, Set(keys(keyvalues)))
  all_valid = reduce(is_valid_field, keyvalues, init=true)
  length(diff) == 0 && all_valid
end

function count_valid(passports)
  length([passport for passport in passports if is_valid(passport)])
end

passports = read_passports("./04_input.txt")
# passports = read_passports("./04_sample.txt")

count_valid(passports)
function read_groups(path)
  split(read(path, String), r"\n\n+")
end

function questions_for_group(group)
  questions = Dict()
  persons = split(group, "\n")
  for person in persons, question in split(person, "")
    if haskey(question, questions)
      questions[question] += 1
    else
      questions[question] = 0
    end
  end
  println("questions: ", questions)

  all_yes = []
  for k in keys(questions)
    if questions[k] == length(persons)
      push!(all_yes, k)
    end
  end
  println("all_yes: ", all_yes)
  all_yes
end

function count_groups(groups)
  counts = map(x -> length(questions_for_group(strip(x))), groups)
  sum(counts)
end

groups = read_groups("./06_sample.txt")
count_groups(groups)

questions_for_group(groups[1])
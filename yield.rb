def hello
  puts  "hello"
  yield
  puts "welcome"
end

hello do
  puts "emma"
end

hello { puts "emma"; puts "Today i'am cold"}

# model code
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/asked.db")

# class~end : class 만드는 문법
class Question
  include DataMapper::Resource # datamapper 객체로 question class를 만드는 것
  property :id, Serial
  property :name, String
  property :content, Text
  property :created_at, DateTime
end

class User
  include DataMapper::Resource
  property :id, Serial
  property :email, String
  property :password, String
  property :is_admin?, Boolean, :default => false
  property :created_at, DateTime
end

DataMapper.finalize

Question.auto_upgrade!
User.auto_upgrade!

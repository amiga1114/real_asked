require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper'
require './model.rb' #database 관련 파일

set :bind, '0.0.0.0'

enable :sessions # 내가 앱에서 세션을 활용할거

get '/' do
  @questions = Question.all # [배열로 구성됨]
  erb :index
end

get '/ask' do
  Question.create(
    :name => params["name"],
    :content => params["question"]
  )
  redirect to '/'
end

get '/signup' do
  erb :signup
end

get '/register' do
  User.create(
    :email => params["email"],
    :password => params["password"]
  )
  redirect to '/'
end

get '/admin' do
  @users = User.all
  erb :admin
end

get '/login' do
  erb :login
end

get '/login_session' do
  @message = ""
  if User.first(:email => params["email"])
    if User.first(:email => params["email"]).password == params["password"]
      session[:email] = params["email"]
      redirect to '/'
      # session = {}
      # {:email => "asdf@asdf.com"}
    else
      @message = "비번이 틀렸어요"
    end
  else
    @message = "해당하는 이메일의 유저가 없습니다"
  end
end

get '/logout' do
  session.clear
  redirect to '/'
end
# login?
# 1.로그인 하려고 하는 사람이 우리 회원인지 확인
# - User 데이터베이스에 있는 사람인지 확인
# - 로그인하려고 하는 사람이 제출한 이메일이 User DB에 있는지 확인
# 2. 만약 있으면
# - 비밀번호를 체크한다 == (제출한 비번 == db의 비번)
#    2-1. 만약 맞으면
#     - 로그인 시킴
#    2-2. 비번이 틀리면
#     - 다시 비번 치라고 한다.
#3. 없으면
# - 회원 아님 -> 회원가입 페이지로 보냄

require './config/environment'

class ApplicationController < Sinatra::Base

  register Sinatra::ActiveRecordExtension

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
  if params[:username] == "" || params[:email] == "" || params[:password] == ""
    redirect to '/signup'
  else
    @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    @user.save
    session[:user_id] = @user.id
    redirect to 'todos/create'
  end
end

get '/login' do
  @user = User.find_by(:username => params[:username])

  if @user != nil && @user.password == params[:password]
    session[:user_id] = @user.id
    redirect to :'/todos'
  end
 erb :error
end

  get '/logout' do
    session.clear
    redirect '/'
  end

end

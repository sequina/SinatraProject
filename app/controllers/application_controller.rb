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

  get '/todo_list' do
    erb :'/todos/todo_list'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/create' do
    erb :'/todos/create_todo'
  end

end

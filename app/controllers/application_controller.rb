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

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user
    end
  end


  # post '/login' do
  #   @user = User.find_by(:username => params[:username])
  #
  #   if @user != nil && @user.password == params[:password]
  #     session[:user_id] = @user.id
  #     redirect to 'users/login'
  #   end
  #  erb :error
  # end
  #
  # get '/logout' do
  #   session.clear
  #   redirect '/'
  # end

end

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

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user
    end
  end
  #
  # get '/logout' do
  #   session.clear
  #   redirect '/'
  # end

end

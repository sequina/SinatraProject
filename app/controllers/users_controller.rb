class UsersController < ApplicationController

  get 'signup' do
    if !logged_in?
      erb :'hello world'
    else
      # redirect to '/login'
    end
  end

  post '/signup' do
  if params[:username] == "" || params[:email] == "" || params[:password] == ""
    # redirect to '/todoList'
  else
    @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    @user.save
    session[:user_id] = @user.id
    # redirect to '/tweet'
  end
end


end

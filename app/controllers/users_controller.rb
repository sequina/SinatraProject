class UsersController < ApplicationController

  get '/signup' do
    erb :'users/create_user'
  end

  # after signing up user is automatically logged in and redirected to todo list
    post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/create'
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])

    if @user != nil && @user.password == params[:password]
      session[:user_id] = @user.id
      redirect to :'todos/create_todo'
    end
   erb :error
  end

  get '/todo_list' do
    @current_user = User.find_by_id(session[:user_id])
    if @current_user
      erb :'/todos/create_todo'
    else
      erb :login
    end
  end


end

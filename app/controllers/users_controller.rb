class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    # erb :'users/show'
  end

  get '/signup' do
    if !logged_in?
      erb :'users/create_user', locals: {message: "Please sign up before you sign in"}
    else
      redirect to '/todos/show'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""

      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/todos'
    end
  end


  get '/login' do
    if logged_in?
      redirect '/todos'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/todos/create"
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
      @current_user = nil
      session.destroy
      redirect to '/login'
  end

  delete '/users/:slug/:id/delete' do
    if logged_in?
      @todo = Todo.find_by_id(params[:id])
       if @todo && @todo.user == current_user
         @todo.destroy
       end
       redirect to '/todos'
       else
         redirect to '/login'
       end
     end
   end

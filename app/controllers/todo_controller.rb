require_relative '../../config/environment'
class TodoController < ApplicationController

  get '/todos' do
    if logged_in?
      @todo = Todo.all
     erb :'todos/show'
   else
     redirect to '/login'
   end
  end

  get '/todos/new' do
    @todo = Todo.create(params)
    erb :'todos/create'
  end

  post '/todos/new' do
    if logged_in?
      if params[:content] == ""
        redirect to '/login'
      else
        @todo = current_user.todos.build(content:params[:content])
        if @todo.save
          redirect to "/todos/#{@todo.id}"
        else
          redirect to '/todos/new'
        end
      end
    else
      redirect to '/todos/show'
    end
  end

  get '/todos/:id' do
    if logged_in?
      @todo = Todo.find_by_id(params[:id])
      erb :'/users/show'
    else
      redirect to '/login'
    end
  end

   get '/todos/:id/edit' do
     if logged_in?
       @todo = Todo.find_by_id(params[:id])
       if @todo && @todo.user == current_user
         erb :'todos/edit'
       else
         redirect to '/todos'
       end
     else
       redirect to '/login'
     end
   end

  patch '/todos/:id' do
    if logged_in?
       if params[:content] == ""
         redirect to "/todos/#{params[:id]/edit}"
       else
         @todo = Todo.find_by_id(params[:id])
         @todo.content = params[:id]
         @todo.save

         if @todo && @todo.user == current_user
           if @todo.update(content:params[:content])
             redirect to '/todos/show'
           else
             redirect to "/todos/#{@todo.id}/edit"
           end
         else
           redirect to '/todos'
         end
       end
     else
       redirect to '/login'
     end
   end

  delete '/todos/:id/delete' do
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

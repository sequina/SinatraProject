require_relative '../../config/environment'
class TodoController < ApplicationController

  get '/todos' do
    if logged_in?
     @todo = Todo.all
     # binding.pry
     erb :'todos/show'
   else
     redirect to '/login'
   end
  end

  get '/todos/new' do
    @todo = Todo.create(params)
    erb :'todos/new'
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
         # binding.pry
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

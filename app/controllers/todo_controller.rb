require_relative '../../config/environment'
class TodoController < ApplicationController

  get '/todos' do
    if logged_in?
     @todo = Todo.all
     erb :'todos/create'
   else
     redirect to '/login'
   end
  end

  get '/todos/new' do
    @todo = Todo.create(params)
    erb :'todos/new'
  end

  post '/todos' do
    if logged_in?
      if params[:content] == ""
        redirect to '/todos/new'
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
    erb :'/todos/show'
  else
    redirect to '/login'
  end
end

   get '/todos/:id/edit' do
     if logged_in?
       @todo = Todo.find_by_id(params[:id])
       if @todo && @todo.users == current_user
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
         if @todo && @todo.users == current_user
           if @todo.update(content:params[:content])
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

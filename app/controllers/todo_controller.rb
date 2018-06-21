require_relative '../../config/environment'
class TodoController < ApplicationController

  get '/todos/new' do
    erb :'todos/new'
  end

  post '/todos' do
    @todo = Todo.create(params)
    redirect to '/todos/create'
  end

   get '/todos' do
     binding.pry
     if logged_in?
      @todo = Todo.all
      erb :'todos/list'
    else
      redirect to '/login'
    end
   end

   get '/todos/:id' do
     @todo = Todo.find_by_id(params[:id])
     erb :'/todos/list'
   end

   get '/todos/:id/edit' do
    @todo = Todo.find_by_id(params[:id])
    erb :edit
  end

   patch '/todos/:id' do
     @todo = Todo.find_by_id(params[:id])
     @todo.name = params[:name]
     @todo.content = params[:content]
     @todo.save
     erb :'/todos/list'
   end

   delete '/todos/:id/delete' do
     @todo = Todo.find_by_id(params[:id])
     @todo.delete
     redirect to '/todos'
   end
end

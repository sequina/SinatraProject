require_relative '../../config/environment'
class UsersController < ApplicationController

   get '/todos' do
     erb :'/todos/create'
   end

   get '/todos/:id' do
     erb :'/todos/list'
   end

   get 'todos/new' do
     erb :'todos/new'
   end

   post '/todos' do
     @todo = Todo.create(params)
     redirect to '/todos/new'
   end

   get '/todos/:id/edit' do
     "this is to edit a todo"
   end

   patch '/todos/:id'
     @todo = Todo.find_by_id(params[:id])
     @todo.name = params[:name]
     @todo.content = params[:content]
     @todo.save
     erb :'/todos/list'
   end

   delete '/todos/:id' do
     "this should delete all the things!"
   end
end

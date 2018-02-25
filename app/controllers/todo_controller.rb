class TodoController < ApplicationController

  get '/todo' do
    @todo = Todo.all
    erb :'todos/create_todo'
  end


end

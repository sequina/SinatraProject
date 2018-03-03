class TodoController < ApplicationController

  get '/todo' do
    if logged_in?
      erb :'todos/create_todo'
    else
      redirect to '/login'
    end
  end

  get '/todo/new' do
    'Hello World, this is new todo'
  end

  post '/todo' do
    'hellow work this is post /todo'
  end

end

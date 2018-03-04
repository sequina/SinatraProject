class TodoController < ApplicationController

  get '/todo' do
    if logged_in?
      erb :'todos/create_todo'
    else
      redirect to '/login'
    end
  end

  get '/todo/new' do
    @todo = Todo.all
    erb :'/todos/todo_list'
  end

  get '/todo/:id/edit' do
    @todo = Todo.find_by_id(params[:id])
    @todo = Todo.all
    erb :'/todos/edit_todo'
  end

  post '/todo/:id' do
    @todo = Todo.find_by_id(params[:id])
    @todo.update(params[:content])

    if !params[:title].empty?
      @title = Title.create(name: params[:title][:name])
      @title.todos << @title
    end

    @todo.save
    redirect to :'/todos/#{@todo.id}'
  end

  get '/todo/:id' do
    @todos = Todo.find_by_id(params[:id])
    erb :'/todos/show_todo'
  end

  get '/todos' do
    @todos = Todo.all
    erb :'/todos/todo_list'
  end

end

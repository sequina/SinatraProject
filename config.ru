require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
use ApplicationController
use TodoController

run UsersController


# Restful routing - Routing conventions

# for a CRUD app, we have the following 7 routes:

# Index
# VERB        PATH              Render or Redirect
# GET       '/todos'            erb

# Show
# GET       '/todos/:id'        erb

# New
# GET       '/todos/new'        erb

# Create
# POST      '/todos'            redirect

# Edit
# GET       '/todos/:id/edit'   erb

# Update
# PATCH      '/todos/:id'       redirect

# Delete
# DELETE     '/todos/:id'       redirect

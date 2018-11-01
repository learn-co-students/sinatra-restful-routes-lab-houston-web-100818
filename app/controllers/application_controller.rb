class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect '/recipes'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  post '/recipes' do
    recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect "recipes/#{recipe.id}"
  end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  patch '/recipes/:id' do
    recipe = Recipe.find(params[:id])
    recipe.name = params[:name]
    recipe.ingredients = params[:ingredients]
    recipe.cook_time = params[:cook_time]
    recipe.save
    redirect "recipes/#{recipe.id}"
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  delete '/recipes/:id/delete' do
    Recipe.find(params[:id]).destroy
    redirect '/recipes'
  end

end


# Create a third controller action that uses RESTful routes and renders a form to edit a single recipe. This controller action should update the entry in the database with the changes, and then redirect to the recipe show page

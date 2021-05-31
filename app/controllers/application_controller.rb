class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end
  get '/recipes/new' do
    erb :'/recipes/new'
  end
  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by(id: params[:id])
    if @recipe
      erb :'/recipes/edit'
    else
      erb :failure
    end
  end
  get '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id])
    if @recipe
      erb :'/recipes/show'
    else 
      erb :failure
    end
  end
  post '/recipes' do
    @recipe = Recipe.create(name: params[:recipe][:name], ingredients: params[:recipe][:ingredients], cook_time: params[:recipe][:cook_time])
    puts "This is my ID #{@recipe.id}"
    redirect to "/recipes/#{@recipe.id}"
  end
  patch '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.update(params[:recipe])
    redirect to "/recipes/#{params[:id]}"
  end
  delete '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.destroy
    redirect to "/recipes"
  end
end

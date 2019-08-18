class CategoriesController < ApplicationController
  
  get '/categories' do
    if logged_in?
      # @categories = user.categories.uniq.sort_by { |category| category.title }
      @categories = Category.all
      erb :'categories/index'
    else
      redirect '/login'
    end
  end

  get '/categories/:id' do
    if logged_in?
      @category = Category.find_by_id(params[:id])
      @links = @category.links.select {|link| link.user_id == @user.id }
      erb :'categories/show'
    else
      redirect '/login'
    end
  end
  
  get "/categories/:id/edit" do
    if logged_in?
      @category = Category.find(params[:id])
      erb :'categories/edit'
    else
      redirect '/login'
    end
  end
  
  post "/categories/:id" do
    if logged_in?
    @category = Category.find(params[:id])
    unless Category.valid_params?(params)
      redirect "/categories/#{@category.id}/edit?error=invalid category info"
    end
    @category.update(params.select{|i| i =="title"})
    redirect "/category/#{@category.id}"
  end
end
end
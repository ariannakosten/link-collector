class CategoriesController < ApplicationController
  
  get '/categories' do
    if logged_in?
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
      @category = Category.find_by_id(params[:id])
      erb :'categories/edit'
    else
      redirect '/login'
    end
  end
  
  post "/categories/:id" do
    if logged_in?
    @category = Category.find_by_id(params[:id])
    @category.update(params.select{|i| i == "name"})
    redirect "/category/#{@category.id}"
  end
end
end
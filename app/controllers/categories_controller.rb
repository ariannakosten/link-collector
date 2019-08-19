class CategoriesController < ApplicationController
  
  # lets user view link categories 
  get '/categories' do
    if logged_in?
      @categories = current_user.categories.all
      #@catagories = Catagory.all
      erb :'categories/index'
    else
      redirect '/login'
    end
  end

  # does not allow for creation of a blank category
  post '/categories' do
    if params[:name].empty?
      flash[:field_error] = "Category cannot be blank"
      redirect '/categories/index'
    else
      @user = current_user
      @category = Category.create(name:params[:name], user_id:@user.id)
      redirect '/categories/index'
    end
  end

  # displays a 1 selected category
  get '/categories/:id' do
    if logged_in?
      @category = Category.find_by_id(params[:id])
     #@links = @category.links.select {|link| link.user_id == @user.id }
      erb :'categories/show'
    else
      redirect '/categories/index'
    end
  end

  # lets user view category edit form 
  # does not let a user edit a category not created by itself
  get '/categories/:id/edit' do
    if logged_in?
      @category = Category.find_by_id(params[:id])
      if @category.user_id == current_user.id   #not sure if i want this
        erb :'categories/edit'
      else
        redirect '/categories/index'
      end
    else
       redirect '/login'
    end
  end

  # doesnt let user edit a category with blank content
  patch '/categories/:id' do
    if !params[:name].empty?
      @category = Category.find(params[:id])
      @category.update(name:params[:name])
      flash[:field_error] = "The category has been updated successfully"
      redirect '/categories/index'
    else
      flash[:field_error] = "Fields cannot be blank"
      redirect to "/categories/#{params[:id]}/edit"
    end
  end

  # lets user delete their own category 
  # does not let a user delete a category they did not create
  delete '/categories/:id/delete' do
    if logged_in?
      if current_user.categories.size == 1
        flash[:field_error] = "Sorry you must have at least one category"
        redirect '/categories/index'
      else
        @category = Category.find(params[:id])
        if @category.user_id == current_user.id
          @category.destroy
          flash[:field_error] = "The category has been deleted successfully"
          redirect '/categories/index'
        end
      end
    else
      redirect '/login'
    end
  end

  # help : created to edit links when the erb
  # file adds '/categories' to the edit link
  get '/categories/links/:id/edit' do
    if logged_in?
      @link = Link.find(params[:id])
      @category = Category.find(@link.category_id)
      if @link.user_id == session[:user_id]
        erb :'links/edit'
      else
        redirect '/home'
      end
    else
      redirect '/login'
    end
  end

end
  
  
#   post "/categories/:id" do
#     if logged_in?
#     @category = Category.find_by_id(params[:id])
#     @category.update(params.select{|i| i == "name"})
#     redirect "/category/#{@category.id}"
#   end
# end
#end
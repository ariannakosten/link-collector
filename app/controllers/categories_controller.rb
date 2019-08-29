class CategoriesController < ApplicationController
  
  ## shows all of the users categories ##
  get '/categories' do
    if logged_in?
      @categories = current_user.categories.all
      erb :'categories/index'
    else
      redirect '/login'
    end
  end

  ## retrieves the specific category and renders show page ##
  get '/categories/:id' do
    if logged_in?
      @category = Category.find_by_id(params[:id])
      if current_user.categories.find{|category| category.id == @category.id} 
         erb :'categories/show'
      else
         redirect '/categories'
      end
      else
         redirect '/login'
      end
   end
  
  ## renders the edit page for 1 category if the user has created it ##
  get'/categories/:id/edit' do
    if logged_in?
      @category = Category.find_by_id(params[:id])
     if current_user.categories.find{|category| category.id == @category.id}  
        erb :'categories/edit'
     else
        redirect '/categories'
     end
     else
        redirect '/login'
     end
  end

  ## updates the category name if params are entered correctly ##
  patch '/categories/:id' do
    @category = Category.find_by(id: params[:id])
    if logged_in? && current_user.categories.find{|category| category.id == @category.id} 
      if params[:category_name].strip != "" && !Category.find_by(name: params[:category_name]) #if category is empty / cant find the category name
        @category.update(name: params[:category_name])
        flash[:field_error] = "The category has been updated successfully"
        redirect "/categories/#{@category.id}"
      else
        flash[:field_error] = "Error: Category name must not already exist or be empty"
        redirect to "/categories/#{params[:id]}/edit"
      end
    else
        redirect to '/login'
    end
  end
end

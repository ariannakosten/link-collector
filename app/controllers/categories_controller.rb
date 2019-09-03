class CategoriesController < ApplicationController
  
  get '/categories' do
    authenticate
    @categories = current_user.categories.all
      erb :'categories/index'
  end

  ## retrieves the specific category and renders show page ##
  get '/categories/:id' do
    authenticate
    @category = Category.find_by_id(params[:id])
    if current_user.categories.find{|category| category.id == @category.id} 
      erb :'categories/show'
      else
         redirect '/categories'
    end
  end
  
  ## renders the edit page for 1 category if the user has created it ##
  get'/categories/:id/edit' do
    authenticate
    @category = Category.find_by_id(params[:id])
    if current_user.categories.find{|category| category.id == @category.id}  
      erb :'categories/edit'
      else
        redirect '/categories'
    end
  end

  ## updates the category name if params are entered correctly ##
  patch '/categories/:id' do
    @category = Category.find_by(id: params[:id])
    authorize_category(@category)
    if params[:category_name].strip != "" && !Category.find_by(name: params[:category_name]) 
        @category.update(name: params[:category_name])
        flash[:field_error] = "The category has been updated successfully"
        redirect "/categories/#{@category.id}"
      else
        flash[:field_error] = "Error: Category name must not already exist or be empty"
        redirect to "/categories/#{params[:id]}/edit"
    end
  end
  
end


# def authorize_category(cat)
# 	    authenticate
# 	    redirect '/home' if !cat || !current_user.categories.include?(cat)
#     end

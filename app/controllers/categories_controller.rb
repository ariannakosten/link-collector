class CategoriesController < ApplicationController
  
  get '/categories' do
    if logged_in?
      @categories = current_user.categories.all
      erb :'categories/index'
    else
      redirect '/login'
    end
  end

  # post '/categories' do
  #   if params[:name] == ""
  #     flash[:field_error] = "Category cannot be blank"
  #     redirect '/categories'
  #   else
  #     redirect '/categories/'
  #   end
  # end

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

  patch '/categories/:id' do
    if params[:name] != ""
      @category = Category.find_by(id: params[:id])
      @category.update(name: params[:category_name])
      flash[:field_error] = "The category has been updated successfully"
      redirect "/categories/#{@category.id}"
    else
      flash[:field_error] = "Fields cannot be blank"
      redirect to "/categories/#{params[:id]}/edit"
    end
  end
end

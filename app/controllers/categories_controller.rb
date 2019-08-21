class CategoriesController < ApplicationController
  
  get '/categories' do
    if logged_in?
      @categories = current_user.categories.all
      erb :'categories/index'
    else
      redirect '/login'
    end
  end

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

  get '/categories/:id' do
    if logged_in?
      @category = Category.find_by_id(params[:id])
    #  binding.pry
     # if current_user.categories.find{|category| category.id == @category.id} 
        #@links = @category.links.select {|link| link.user_id == @user.id }
        #binding.pry
         erb :'categories/show'
      # else
      #   redirect '/categories/index'
      # end
    else
      redirect '/categories/index'
    end
  end

  
  get'/categories/:id/edit' do
    if logged_in?
      @category = Category.find_by_id(params[:id])
      #
      #if current_user.categories.find{|category| category.id == @category.id}  
      
        erb :'categories/edit'
      # else
      #   redirect '/categories/index'
      # end
    # if params[:name].empty?
    #   flash[:field_error] = "Category cannot be blank"
    #   redirect '/categories/edit'
    # end
    else
      redirect '/login'
    end
  end

  patch '/categories/:id' do
    if params[:name] != ""
      @category = Category.find_by(id: params[:id])
      @category.update(name: params[:name])
      flash[:field_error] = "The category has been updated successfully"
      redirect '/categories/index'
    else
      flash[:field_error] = "Fields cannot be blank"
      redirect to "/categories/#{params[:id]}/edit"
    end
  end

  # delete '/categories/:id' do
  #   if logged_in?
  #     if current_user.categories.size == 1
  #       flash[:field_error] = "Sorry you must have at least one category"
  #       redirect '/categories/index'
  #     else
  #       @category = Category.find_by(id: params[:id])
  #       if current_user.categories.find{|category| category.id == @category.id} 
  #         @category.destroy
  #         flash[:field_error] = "The category has been deleted successfully"
  #         redirect '/categories/index'
  #       end
  #     end
  #   else
  #     redirect '/login'
  #   end
  #end

  # get '/categories/links/:id/edit' do
  #   if logged_in?
  #     @link = Link.find(params[:id])
  #     @category = Category.find(@link.category_id)
  #     if @link.user_id == session[:user_id]
  #       erb :'links/edit'
  #     else
  #       redirect '/home'
  #     end
  #   else
  #     redirect '/login'
  #   end
  # end
end

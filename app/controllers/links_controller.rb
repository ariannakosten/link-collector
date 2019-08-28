class LinksController < ApplicationController
  
  get '/links' do
    if logged_in?
      @links = current_user.links 
         erb :'links/index'
      else
         redirect '/login' 
      end
   end
   
  get '/links/new' do
    if logged_in?
      erb :'/links/new'
    else
      redirect '/login'
    end
  end

  post '/links' do
    
    if links_valid_params(params)
      @user = current_user
      @category = Category.find_or_create_by(name: params[:category_name])
      @link = Link.create(name: params[:link_name], description: params[:link_description], category_id: @category.id, user_id: @user.id)
      flash[:field_error] = "Link successfully added!"
      redirect to "/links"
    else
      flash[:field_error] = "All fields must be filled out"
      redirect to "/links/new"
    end
    
  end

  get '/links/:id' do
    if logged_in?
      @link = Link.find_by(id: params[:id])
      @category = @link.category
      if current_user.links.find{|link| link.id == @link.id} 
         erb :'links/show'
      else
         redirect '/links'
      end
      else
      redirect '/login'
    end
  end

  get '/links/:id/edit' do
    if logged_in?
      @link = Link.find_by(id: params[:id])
      @category = Category.find(@link.category_id)
      if current_user.links.find{|link| link.id == @link.id} 
         erb :'links/edit'
      else
         redirect '/home'
      end
      else
      redirect '/login'
    end
  end

  patch '/links/:id' do
    if links_valid_params(params)
      @link = Link.find_by(id: params[:id])
      @link.update(name: params[:link_name], description: params[:link_description])
      @category = Category.find_or_create_by(name: params[:category_name])
      @link.category = @category
      @link.save
      flash[:feild_error] = "Link successfully updated!"
      redirect "/links/#{@link.id}"
    else
      flash[:feild_error] = "All fields must be filled out"
      redirect to "/links/#{params[:id]}/edit"
    end
  end
  
  delete '/links/:id' do 
    if !logged_in?
      redirect to '/login'
    else
    @link = Link.find_by(id: params[:id])
    @link.destroy
    if current_user.links.find{|link| link.id == @link.id} 
      flash[:field_error] = "Your link has been deleted"
      redirect to '/links'
    else
      redirect '/home'
      end
    end 
  end
end
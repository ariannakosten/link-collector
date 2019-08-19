class LinksController < ApplicationController
  
  get '/links' do
    if logged_in?
      @links = Link.all
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
    if params[:link_name] == "" || params[:link_description] == "" || params[:category_name] == ""
      flash[:field_error] = "All fields must be filled out"
      redirect to "/links/new"
    else
      @user = current_user
      @category = Category.find_or_create_by(name: params[:category_name])
      @link = Link.create(name: params[:link_name], description: params[:link_description], category_id: @category.id, user_id: @user.id)
      redirect to "/links"
    end
  end

  get '/links/:id' do
    if logged_in?
      @link = Link.find_by(id: params[:id])
      @category = @link.category
      erb :'links/show'
    else
      redirect '/login'
    end
  end

  get '/links/:id/edit' do
    if logged_in?
      @link = Link.find(params[:id])
      @category = Category.find(@link.category_id)
        erb :'links/edit'
      else
        redirect '/home'
      end
    end

  patch '/links/:id' do
    if params[:link_name] != "" && params[:link_description] != "" && params[:category_name] != ""
      @link = Link.find_by(id: params[:id])
      @link.update(name: params[:link_name], description: params[:link_description])
      @category = @link.category
      @category.name =  params[:category_name]
      @link.save
      @category.save
      redirect "/links/#{@link.id}"
    else
      flash[:feild_error] = "All fields must be filled out"
      redirect to "/links/#{params[:id]}/edit"
    end
  end
  
  delete '/links/:id/delete' do 
    if !logged_in?
      redirect to '/login'
    else
    @link = Link.find(params[:id])
    @link.destroy
    flash[:field_error] = "Your link has been deleted"
      redirect to '/links'
    end 
  end
end
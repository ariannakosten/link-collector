class LinksController < ApplicationController
  
  ## shows all of the users links ##
  get '/links' do
    authenticate
    @links = current_user.links 
    erb :'links/index'
  end
   
  ## gets the form to add a new link ## 
  get '/links/new' do
    authenticate
    erb :'/links/new'
  end

  ## creates the link if params are valid and user is logged in ##
  post '/links' do
    authenticate
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

  ## renders the specific link to show if it is one the user created ##
  get '/links/:id' do
    authenticate
    @link = Link.find_by(id: params[:id])
    @category = @link.category
    if current_user.links.find{|link| link.id == @link.id} 
      erb :'links/show'
    else
      redirect '/links'
    end
  end
  
  ## displays the edit page for links ##
  get '/links/:id/edit' do
    authenticate
    @link = Link.find_by(id: params[:id])
    @category = Category.find(@link.category_id)
    if current_user.links.find{|link| link.id == @link.id} 
      erb :'links/edit'
    else
      redirect '/home'
    end
  end
  
  ## edits the specific link if the user has created it himself and has entered valid params to edit --redirects to link show page ##
  patch '/links/:id' do
    @link = Link.find_by(id: params[:id])
    authorize_link(@link)
      if links_valid_params(params) && current_user.links.find{|link| link.id == @link.id}
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
  
  ## deletes current link if user is logged in & has created the link himself --otherwise directs to home or login ##
  delete '/links/:id' do 
    authenticate
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
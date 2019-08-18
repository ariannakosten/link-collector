class LinksController < ApplicationController
# lets a user view all linkss if logged in
  # redirects to login page if not logged in
  get '/links' do
    if logged_in?
      erb :'links/index'
    else
      redirect '/login'
    end
  end

  # lets user create link if they are logged in
  get '/links/new' do
    if logged_in?
      erb :'/links/new'
    else
      redirect '/login'
    end
  end

  # does not let a user create a blank link details
  post '/links' do
    if params[:name].empty? || params[:description].empty? || params[:category_name].empty?
      flash[:field_error] = "Fields cannot be blank"
      redirect to "/links/new"
    else
      @user = current_user
      @category = @user.categories.find_or_create_by(name:params[:category_name])
      @category.user_id = @user.id
      @link = Link.create(link:params[:name], description:params[:description], category:params[:category_name], category_id:@category.id, user_id:@user.id)
      redirect to "/links/#{@link.id}"
    end
  end

  # displays 1 link
  get '/links/:id' do
    if logged_in?
      @link = Link.find(params[:id])
      erb :'links/show'
    else
      redirect '/login'
    end
  end

  # lets a user view link edit form if they are logged in
  # does not let a user edit a link he/she did not create
  get '/links/:id/edit' do
    if logged_in?
      @link = Link.find(params[:id])
      @category = Category.find(@link.category_id)
      if @link.user_id == current_user.id
        erb :'links/edit'
      else
        redirect '/home'
      end
    else
      redirect '/login'
    end
  end

  # does not let a user edit a text with blank content
  patch '/links/:id' do
    if !params[:name].empty? && !params[:description].empty? && !params[:category].empty?
      @link = Link.find(params[:id])
      @link.update(link:params[:name], description:params[:description], category:params[:category_name])
      @category = current_user.categories.find_by(name:params[:category_name])
      @link.category_id = @category.id
      @link.save
      flash[:field_error] = "Your Link Has Been Succesfully Updated"
      redirect '/home'
    else
      flash[:feil_error] = "Fields Cannot Be Blank"
      redirect to "/links/#{params[:id]}/edit"
    end
  end

  # lets a user delete their own link if they are logged in
  # does not let a user delete a link they did not create
  delete '/links/:id/delete' do
    if logged_in?
      @link = Link.find(params[:id])
      if @link.user_id == current_user.id
        @link.delete
        flash[:field_error] = "Your link has been deleted"
        redirect '/home'
      end
    else
      redirect '/login'
    end
  end

end

#   get '/links' do
#     if logged_in?
#       @user = current_user
#       @links = @user.links
#       # @links = Link.all
#       erb :'links/index'
#     else
#       redirect '/login'
#     end
#   end
  
#   get '/links/new' do
#     if logged_in?
#       # @categories = Category.all
#       erb :'links/new'
#     else 
#       redirect '/login'
#     end
#   end

  
#   post '/links' do
#     @user = current_user
#     if params[:name] == "" || params[:description] == "" || params[:category] == "" 
#       redirect to '/links/new'
#     end
#       @link = @user.links.create(name: params[:name], description: params[:description], category: params[:category])
#     redirect to '/links'
#   end 
  
#   get '/links/:id' do
#     if !logged_in?
#       redirect to '/login'
#     end
#     @link = Link.find(params[:id])
#     erb :"links/show"
#   end
  
#   get '/links/:id/edit' do
#     if !logged_in?
#       redirect to '/login'
#     end
#     @link = Link.find(params[:id])
#     erb :"links/edit"
#   end
  
#   patch '/links/:id' do
#     link = Link.find(params[:id])
#     if params[:name] == "" || params[:description] == "" || params[:category] == "" 
#       redirect to "/links/#{params[:id]}/edit"
#     end
#     link.update(name: params[:name], description: params[:description], category: params[:category])
 
#     redirect to "/links/#{link.id}"
#   end

#   delete '/links/:id/delete' do 
#     if !logged_in?
#       redirect to '/login'
#     else
#     @link = Link.find(params[:id])
#     @link.delete
#       redirect to '/links'
#     end 
#   end 

# end =====================================================

#   get "/links/:id/edit" do  
#   logged_in? 
#     @link = Link.find(params[:id])
#     erb :'links/edit'
#   end
  
#   patch '/links/:id' do   
#     @link = Link.find_by_id(params[:id])    
#     @link.update(params[:link])
        
#       redirect "/links/#{@link.id}"
#   end
#   # @link.update(params.select{|k|k=="name" || k=="description" || k=="category"})

#   get "/links/:id" do
#     logged_in? 
#     @link = Link.find(params[:id])
#     erb :'links/show'
#   end

#   post "/links" do    
#     logged_in? 
#     Link.create(params[:link][:category])
#     redirect "/links"
#   end
  
#   delete '/links/:id' do      
#     @link = Link.find_by_id(params[:id])
#     @link.destroy
#     redirect '/links'
#   end
# end

# ==============
  
  # get '/links' do
  #   if logged_in?
  #     @links = Link.all
  #     erb :'links/index'
  #   else
  #     redirect '/login'
  #   end
  # end
  
  # get '/links/new' do
  #   if logged_in?
  #     @categories = Category.all
  #     #@categories = @user.categories.uniq.sort_by { |category| category.title }
  #     erb :'links/new'
  #   else 
  #     redirect '/login'
  #   end
  # end
  
  # # post '/links' do
  #   if params[:link][:description] == "" || params[:link][:name] == ""
  #     redirect '/links/new'
  #   else
  #     link = @user.links.create(params[:link])
  #     link.categories << Category.find_or_create_by(title: params[:category][:title]) if !params[:category][:title].empty?
  #     redirect '/links'
  #   end
  # end
  
  # get '/links/:id' do
  #   if logged_in?
  #     @link = Link.find_by_id(params[:id])
  #     erb :'links/show'
  #   else
  #     redirect '/login'
  #   end
  # end
  
  # get '/links/:id/edit' do
  #   if logged_in?
  #     @link = Link.find_by_id(params[:id])
  #     @categories = @user.categories.uniq.sort_by { |category| category.title }
  #     erb :'links/edit'
  #   else
  #     redirect '/login'
  #   end
  # end
  
  # patch '/links/:id' do
  #   @link = Link.find_by_id(params[:id])    
  #   if params[:link][:description] == "" || params[:link][:name] == ""
  #     redirect "/links/#{@link.id}/edit"
  #   else
  #     @link.update(params[:link])
  #     @link.categories << Category.find_or_create_by(title: params[:category][:title]) if !params[:category][:title].empty?
  #     redirect "/links/#{@link.id}"
  #   end
  # end
  
  
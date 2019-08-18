class LinksController < ApplicationController
  get '/links' do
    if logged_in?
      @user = current_user
      @links = @user.links
      # @links = Link.all
      erb :'links/index'
    else
      redirect '/login'
    end
  end
  
  get '/links/new' do
    if logged_in?
      # @categories = Category.all
      erb :'links/new'
    else 
      redirect '/login'
    end
  end
  
  # post '/links' do
  #     @links.new(params[:link])
  #     # dream.categories << Category.find_or_create_by(name: params[:category][:name1]) if !params[:category][:name1].empty?
  #     # dream.categories << Category.find_or_create_by(name: params[:category][:name2]) if !params[:category][:name2].empty?
  #     redirect '/links'
  #   end
  
  post '/links' do
    @user = current_user
    if params[:name] == "" || params[:description] == "" || params[:category] == "" 
      redirect to '/links/new'
    end
      @link = @user.links.create(name: params[:name], description: params[:description], category: params[:category])
    redirect to '/links'
  end 
  
  get '/links/:id' do
    if !logged_in?
      redirect to '/login'
    end
    @link = Link.find(params[:id])
    erb :"links/show"
  end
  
  get '/links/:id/edit' do
    if !logged_in?
      redirect to '/login'
    end
    @link = Link.find(params[:id])
    erb :"links/edit"
  end
  
  patch '/links/:id' do
    link = Link.find(params[:id])
    if params[:name] == "" || params[:description] == "" || params[:category] == "" 
      redirect to "/links/#{params[:id]}/edit"
    end
    link.update(name: params[:name], description: params[:description], category: params[:category])
 
    redirect to "/links/#{link.id}"
  end

  delete '/links/:id/delete' do 
    if !logged_in?
      redirect to '/login'
    else
    @link = Link.find(params[:id])
    @link.delete
      redirect to '/links'
    end 
  end 

end 
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
  
  
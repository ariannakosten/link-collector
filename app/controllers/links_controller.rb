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
      @categories = Category.all
      #@categories = @user.categories.uniq.sort_by { |category| category.title }
      erb :'links/new'
    else 
      redirect '/login'
    end
  end

  get "/links/:id/edit" do
   logged_in? 
    @error_message = params[:error]
    @link = Link.find(params[:id])
    erb :'links/edit'
  end

  post "/links/:id" do
    logged_in? 
    @link = Link.find(params[:id])
    # unless Link.valid_params?(params)
    #   redirect "/links/#{@link.id}/edit?error=invalid link info"
    # end
    @link.update(params.select{|k|k=="name" || k=="description" || k=="category"})
    redirect "/links/#{@link.id}"
  end

  get "/links/:id" do
    logged_in? 
    @link = Link.find(params[:id])
    erb :'links/show'
  end

  post "/links" do    #GOOD
    logged_in? 
    Link.create(params[:link][:category])
    redirect "/links"
  end
  
  delete '/links/:id' do      #GOOD
    @link = Link.find_by_id(params[:id])
    @link.destroy
    redirect '/links'
  end
end

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
  
  
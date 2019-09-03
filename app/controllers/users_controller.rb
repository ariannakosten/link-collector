class UsersController < ApplicationController
  
  ## checks to see if user is logged in - directs to home pg --if not directs to signup form ##
  get '/signup' do
    if logged_in?
      redirect '/home'
    else
      erb :'users/signup'
    end
  end
  
  ## checks to see if u.n. & password are filled out - creates user redirects to home -- otherwise redirects to login ##
  post '/signup' do
      @user = User.create(username: params[:username], password: params[:password])
      if @user.save
        session[:user_id] = @user.id
        redirect '/home'
      else
        erb :'users/signup'
      end
    end

  ## checks to see if user is logged in and has signedup - directs to home pg --if not directs to login form ##
  get '/login' do 
    if logged_in?
      redirect '/home' 
    else 
      erb :'users/login'
    end  
  end
  
  ## checks to see if user has entered login info correctly --if not redirects to login form-- otherwise finds the user by the params entered nav to home ##
  post '/login' do
    if params[:username] == "" || params[:password] == ""
      flash[:field_error] = "** A valid email & password are required **"
      redirect '/login'
    else
      @user = User.find_by(username: params[:username])
      @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/home'
    end
  end
  
  ## renders home page if the user is logged in --otherwise redirects to main welcome page ##
  get '/home' do 
    if logged_in?
      erb :'users/home'
    else 
      redirect '/'
    end 
  end
  
  ## ends session if user is logged in ##
  get '/logout' do
    if logged_in?
      session.clear
      redirect '/'
    else
      redirect '/'
    end
  end
  
  get '/search' do
    # @links = Link.all
    if params[:search]
      @cat = Category.find_by(name: params[:search])
      if @cat.nil? 
        redirect '/home'
      else 
      @links = @cat.links
       erb :'/links/index'
     end
    end
  end
end
require './config/environment'


class ApplicationController < Sinatra::Base
  
  ## set configurations ##
  configure do  
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions   
    set :session_secret, "linksonlinksonlinks" #helps authenticate against bcrypt passwords keeps sess safe
    use Rack::Flash
  end

  get '/' do 
    erb :welcome
  end

  helpers do
    ## checks if user is logged in for the session ##
    def logged_in?
      !!session[:user_id]
    end

    ## retrieves current user ##
    def current_user
      @user ||= User.find(session[:user_id]) #if user is undefined, then evaluate User.find and set @user to the result
    end
    
    ## checks if user is authorized. If they're not logged in or the current_user is not found theyre redirected to login (returns true only for nil)
    def authenticate
      if !logged_in? || current_user.nil?
        redirect '/login'
      end
    end
    
    ## helps with validating params for editing / adding links/ categories ##
    def links_valid_params(params)
      if params[:link_name].strip == ""  || params[:link_description].strip == "" || params[:category_name].strip == ""
        false
      else
        true
      end
    end
    
    def authorize_category(cat)
	    authenticate
	    redirect '/home' if !cat || !current_user.categories.include?(cat)
    end
    
    def authorize_link(link)
	    authenticate
	    redirect '/home' if !link || link.user != current_user
    end
    
  end
end

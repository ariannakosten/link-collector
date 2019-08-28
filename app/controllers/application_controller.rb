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
    
    ## helps with validating params for editing / adding links/ categories ##
    def links_valid_params(params)
      if params[:link_name].strip == ""  || params[:link_description].strip == "" || params[:category_name].strip == ""
        false
      else
        true
      end
    end
  end
end

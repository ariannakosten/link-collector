require './config/environment'


class ApplicationController < Sinatra::Base

  configure do  #set configurations
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions   #
    set :session_secret, "linksonlinksonlinks" #helps authenticate against bcrypt passwords keeps sess safe
    use Rack::Flash
  end

  get '/' do 
    erb :welcome
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @user ||= User.find(session[:user_id])
    end
    
    def links_valid_params(params)
      if params[:link_name].strip == ""  || params[:link_description].strip == "" || params[:category_name].strip == ""
        false
      else
        true
      end
    end
  end
end

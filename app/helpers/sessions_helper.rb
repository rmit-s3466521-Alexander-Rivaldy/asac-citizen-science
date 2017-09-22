module SessionsHelper
    
    def log_in(token, refresh_token, name)
        session[:token] = token
        session[:refresh_token] = refresh_token
        session[:name] = name
    end
    
    def current_user
        if (user_id = session[:user_id])
          @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.signed[:user_id])
          user = User.find_by(id: user_id)
          if user && user.authenticated?(:remember, cookies[:remember_token])
            log_in user
            @current_user = user
          end
        end
    end
    
    # Returns true if the user is logged in, false otherwise.
    def logged_in?
        !session[:token].nil?
    end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :if_logged?

  def current_chef
    @current_chef ||= Chef.find session[:chef_id] if session[:chef_id]    
  end

  def if_logged?
    !!current_chef
  end

  def require_user
    if !if_logged?
      flash[:danger] = "You must be logged in ton perfome that action.."
      redirect_to root_path
    else

    end
  end

end

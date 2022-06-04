class ApplicationController < ActionController::Base
  helper_method :signed_in?

   private

  def authenticate_user!
    unless signed_in?
      redirect_to login_path, alert: 'Please sign in first'
    end
  end

  def signed_in?
    session[:current_user_id] != nil
  end
end

class ApplicationController < ActionController::Base

   private

  def authenticate_user!
    redirect_to login_path unless signed_in?
  end

  def redirect_if_authenticated
    redirect_to root_path if signed_in?
  end

  def signed_in?
    session[:current_user_id] != nil
  end
end

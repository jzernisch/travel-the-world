class SessionsController < ApplicationController
  before_action :redirect_if_authenticated, only: [:new, :create]
  before_action :authenticate_user!, only: [:destroy]

  def create
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      login(user)
      redirect_to root_path
    else
      render :new, status: 422
    end
  end

  def destroy
    reset_session
  end

  private

  def login(user)
    session[:current_user_id] = user.id
  end
end

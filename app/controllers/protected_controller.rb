class ProtectedController < ApplicationController
  before_action :authenticate_user!
  
  def home
  end
end

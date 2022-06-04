require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  class NewTest < self
    test 'sessions#new shows no logout button when not logged in' do
      get '/login'
      assert_select "button", text: "Logout", count: 0
    end

    test 'sessions#new redirects to root when already logged in' do
      login_with_valid_credentials
      get '/login'
      assert_redirected_to root_path
    end

    test 'sessions#new shows a flash alert when already logged in' do
      login_with_valid_credentials
      get '/login'
      assert_equal 'You are already logged in', flash[:alert]
    end
  end

  class CreateTest < self
    test "sessions#create returns 422 for a non-existing user" do
      login_with_non_existing_user
      assert_response 422
    end

    test "sessions#create shows a flash alert for a non-existing user" do
      login_with_non_existing_user
      assert_equal 'Invalid credentials', flash[:alert]
    end

    test "sessions#create returns 422 for an existing user with invalid credentials" do
      login_with_invalid_credentials
      assert_response 422
    end

    test "sessions#create shows a flash alert for an existing user with invalid credentials" do
      login_with_invalid_credentials
      assert_equal 'Invalid credentials', flash[:alert]
    end

    test "sessions#create redirects to root after successful login" do
      login_with_valid_credentials
      assert_redirected_to root_path
    end

    test "sessions#create shows a flash notice after successful login" do
      login_with_valid_credentials
      assert_equal 'Successful login', flash[:notice]
    end

    test "sessions#create puts the user id in the session after successful login" do
      user = login_with_valid_credentials
      assert_equal user.id, session[:current_user_id]
    end

    test 'sessions#create shows a logout button after successful login' do
      login_with_valid_credentials
      follow_redirect!
      assert_select "button", text: "Logout"
    end

    test 'sessions#create login shows a flash alert when already logged in' do
      login_with_valid_credentials
      post '/login'
      assert_equal 'You are already logged in', flash[:alert]
    end
  end

  class DestroyTest < self
    test 'sessions#destroy removes the user id from the session' do
      login_with_valid_credentials
      delete '/logout'
      assert_nil session[:current_user_id]
    end

    test 'sessions#destroy redirects to login if user is not logged in' do
      delete '/logout'
      assert_redirected_to login_path
    end

    test 'sessions#destroy shows a flash notice' do
      login_with_valid_credentials
      delete '/logout'
      assert_equal 'You have been signed out', flash[:notice]
    end

    test 'sessions#destroy hides the logout button' do
      login_with_valid_credentials
      delete '/logout'
      assert_select "button", text: "Logout", count: 0
    end
  end

  def login_with_invalid_credentials
    user = users(:one)
    post '/login', params: { user: { email: user.email, password: 'wrong_password' } }
  end

  def login_with_non_existing_user
    post '/login', params: { user: { email: 'no_name@bar.com', password: 'password' } }
  end

  def login_with_valid_credentials
    user = users(:one)
    post '/login', params: { user: { email: user.email, password: 'password' } }
    user
  end
end

require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'login page shows no logout button' do
    get '/login'
    assert_select "button", text: "Logout", count: 0
  end

  test "login returns 422 for a non-existing user" do
    post '/login', params: { user: { email: 'no_name@bar.com', password: 'password' } }
    assert_response 422
  end

  test "login shows a flash alert for a non-existing user" do
    post '/login', params: { user: { email: 'no_name@bar.com', password: 'password' } }
    assert_equal 'Invalid credentials', flash[:alert]
  end

  test "login returns 422 for an existing user with invalid credentials" do
    user = users(:one)
    post '/login', params: { user: { email: user.email, password: 'wrong_password' } }
    assert_response 422
  end

  test "login shows a flash alert for an existing user with invalid credentials" do
    user = users(:one)
    post '/login', params: { user: { email: user.email, password: 'wrong_password' } }
    assert_equal 'Invalid credentials', flash[:alert]
  end

  test "login redirects to root after successful login" do
    user = users(:one)
    post '/login', params: { user: { email: user.email, password: 'password' } }
    assert_redirected_to root_path
  end

  test "login shows a flash notice after successful login" do
    user = users(:one)
    post '/login', params: { user: { email: user.email, password: 'password' } }
    assert_equal 'Successful login', flash[:notice]
  end

  test "login puts the user id in the session after successful login" do
    user = users(:one)
    post '/login', params: { user: { email: user.email, password: 'password' } }
    assert_equal user.id, session[:current_user_id]
  end

  test 'login shows a logout button after successful login' do
    user = users(:one)
    post '/login', params: { user: { email: user.email, password: 'password' } }
    follow_redirect!
    assert_select "button", text: "Logout"
  end

  test 'login page redirects to root when already logged in' do
    user = users(:one)
    post '/login', params: { user: { email: user.email, password: 'password' } }
    get '/login'
    assert_redirected_to root_path
  end

  test 'login page shows a flash alert when already logged in' do
    user = users(:one)
    post '/login', params: { user: { email: user.email, password: 'password' } }
    get '/login'
    assert_equal 'You are already logged in', flash[:alert]
  end

  test 'login redirects to root when already logged in' do
    user = users(:one)
    post '/login', params: { user: { email: user.email, password: 'password' } }
    post '/login'
    assert_redirected_to root_path
  end

  test 'login shows a flash alert when already logged in' do
    user = users(:one)
    post '/login', params: { user: { email: user.email, password: 'password' } }
    post '/login'
    assert_equal 'You are already logged in', flash[:alert]
  end

  test 'logout removes the user id from the session' do
    user = users(:one)
    post '/login', params: { user: { email: user.email, password: 'password' } }
    delete '/logout'
    assert_nil session[:current_user_id]
  end

  test 'logout redirects to login if user is not logged in' do
    delete '/logout'
    assert_redirected_to login_path
  end

  test 'logout shows a flash notice' do
    user = users(:one)
    post '/login', params: { user: { email: user.email, password: 'password' } }
    delete '/logout'
    assert_equal 'You have been signed out', flash[:notice]
  end

  test 'logout hides the logout button' do
    user = users(:one)
    post '/login', params: { user: { email: user.email, password: 'password' } }
    delete '/logout'
    assert_select "button", text: "Logout", count: 0
  end
end

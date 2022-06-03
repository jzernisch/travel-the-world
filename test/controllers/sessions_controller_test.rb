require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "login returns 422 for an non-existing user" do
    post '/login', params: { user: { email: 'no_name@bar.com', password: 'password' } }
    assert_response 422
  end

  test "login returns 422 for an existing user with invalid credentials" do
    user = users(:one)
    post '/login', params: { user: { email: user.email, password: 'wrong_password' } }
    assert_response 422
  end

  test "login redirects to root after successful login" do
    user = users(:one)
    post '/login', params: { user: { email: user.email, password: 'password' } }
    assert_redirected_to root_path
  end

  test "login puts the user id in the session after successful login" do
    user = users(:one)
    post '/login', params: { user: { email: user.email, password: 'password' } }
    assert_equal user.id, session[:current_user_id]
  end

  test 'login page redirects to root when already logged in' do
    user = users(:one)
    post '/login', params: { user: { email: user.email, password: 'password' } }
    get '/login'
    assert_redirected_to root_path
  end

  test 'login post request redirects to root when already logged in' do
    user = users(:one)
    post '/login', params: { user: { email: user.email, password: 'password' } }
    post '/login'
    assert_redirected_to root_path
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
end

require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "root redirects to login when not authenticated" do
    get '/'
    assert_redirected_to login_path
  end

  test "root shows a flash notice when not authenticated" do
    get '/'
    assert_equal 'Please sign in first', flash[:alert]
  end

  test "visit returns 200 when user is authenticated" do
    user_params = { email: 'foo@bar.com', password: 'password' }
    user = User.create(user_params)
    post '/login', params: { user: { email: user.email, password: user.password } }
    get '/'
    assert_response 200
  end
end

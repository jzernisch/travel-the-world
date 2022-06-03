require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should redirect to login when not authenticated" do
    get '/'
    assert_redirected_to login_path
  end

  test "should return 200 when user is authenticated" do
    user_params = { email: 'foo@bar.com', password: 'password' }
    user = User.create(user_params)
    post '/login', params: { user: { email: user.email, password: user.password } }
    get '/'
    assert_response 200
  end
end

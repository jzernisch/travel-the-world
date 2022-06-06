require "test_helper"

class ProtectedControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "it redirects to login page user which is not logged in" do
    get protected_home_url

    assert_redirected_to new_user_session_path
  end

  test "it shows protected page when user is logged in" do
    sign_in users(:sherlock)

    get protected_home_url

    assert_response :success
    assert_select "h1", "Protected"
  end
end

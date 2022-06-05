require "test_helper"

class ProtectedControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get protected_home_url
    assert_response :success
  end
end

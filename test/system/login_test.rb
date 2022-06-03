require "application_system_test_case"

class LoginTest < ApplicationSystemTestCase
  test "successful login redirects to home" do
    visit 'login'

    fill_in 'email', with: 'foo@test.com'
    fill_in 'password', with: 'c0rrectPW'

    assert_selector "h1", text: "Home"
  end

  test "failed login redirects to login again" do
    visit 'login'

    fill_in 'email', with: 'foo@test.com'
    fill_in 'password', with: 'invalidPW'

    assert_selector "h1", text: "Login"
  end
end

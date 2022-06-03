require "application_system_test_case"

class LoginTest < ApplicationSystemTestCase
  test 'visiting root redirects to login if not logged in' do
    visit '/'

    assert_selector "h1", text: "Login"
  end

  test "successful login redirects to home" do
    visit 'login'

    fill_in 'user_email', with: 'foo@bar.com'
    fill_in 'user_password', with: 'password'

    click_on 'Sign In'

    assert_selector "h1", text: "Home"
  end

  test "failed login redirects to login again" do
    visit 'login'

    fill_in 'user_email', with: 'foo@bar.com'
    fill_in 'user_password', with: 'wrong_password'

    click_on 'Sign In'

    assert_selector "h1", text: "Login"
  end
end

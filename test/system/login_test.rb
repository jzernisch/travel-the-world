require "application_system_test_case"

class LoginTest < ApplicationSystemTestCase
  test 'unauthenticated access' do
    visit '/'

    assert_selector "h1", text: "Login"
    assert_no_selector "button", text: "Logout"
    assert_selector "div", text: "Please sign in first"
  end

  test "successful login" do
    visit 'login'

    fill_in 'user_email', with: 'foo@bar.com'
    fill_in 'user_password', with: 'password'
    click_on 'Sign In'

    assert_selector "h1", text: "Home"
    assert_selector "button", text: "Logout"
    assert_selector "div", text: "Successful login"
  end

  test "failed login" do
    visit 'login'

    fill_in 'user_email', with: 'foo@bar.com'
    fill_in 'user_password', with: 'wrong_password'
    click_on 'Sign In'

    assert_selector "h1", text: "Login"
    assert_no_selector "button", text: "Logout"
    assert_selector "div", text: "Invalid credentials"
  end

  test "logout" do
    visit 'login'

    fill_in 'user_email', with: 'foo@bar.com'
    fill_in 'user_password', with: 'password'
    click_on 'Sign In'
    click_on 'Logout'

    assert_selector "h1", text: "Login"
    assert_no_selector "button", text: "Logout"
    assert_selector "div", text: "You have been signed out"
  end
end

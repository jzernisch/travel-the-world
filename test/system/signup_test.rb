require "application_system_test_case"

class SignupTest < ApplicationSystemTestCase
  test "successful signup and subsequent login" do
    visit 'login'

    click_on 'Sign Up'

    assert_selector "h1", text: "Sign Up"

    fill_in 'user_email', with: 'new_user@bar.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_on 'Sign Up'

    assert_selector "h1", text: "Login"
    assert_selector "div", text: "You can now sign in with your credentials"

    fill_in 'user_email', with: 'new_user@bar.com'
    fill_in 'user_password', with: 'password'
    click_on 'Sign In'

    assert_selector "h1", text: "Home"
  end

  test "failed signup" do
    visit 'login'

    click_on 'Sign Up'

    assert_selector "h1", text: "Sign Up"

    fill_in 'user_email', with: 'foo@bar.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'passssworrrrrd'
    click_on 'Sign Up'

    assert_selector "h1", text: "Sign Up"
  end
end

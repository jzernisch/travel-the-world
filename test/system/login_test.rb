require "application_system_test_case"

class LoginTest < ApplicationSystemTestCase
  test 'it logs in user with correct credentials' do
    visit new_user_session_path

    assert_selector 'h2', text: 'Log in'

    fill_in 'Email', with: users(:sherlock).email
    fill_in 'Password', with: 'SherlockHolmes'

    click_on 'Log in'

    assert_text 'Signed in successfully'
    assert_text 'Sign out'
  end

  test 'it does not login user with incorrect credentials' do
    visit new_user_session_path

    assert_selector 'h2', text: 'Log in'

    fill_in 'Email', with: 'bla@bla.com'
    fill_in 'Password', with: 'bla'

    click_on 'Log in'

    assert_text 'Invalid Email or password'
    assert_text 'Log in'
  end
end

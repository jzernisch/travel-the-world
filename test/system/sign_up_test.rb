require "application_system_test_case"

class SignUpTest < ApplicationSystemTestCase
  test 'it signs up user' do
    visit new_user_registration_path

    assert_selector 'h2', text: 'Sign up'

    fill_in 'Email', with: 'watson@baker.street'
    fill_in 'Password', with: 'DoctorWatson'
    fill_in 'Password confirmation', with: 'DoctorWatson'

    click_on 'Sign up'

    assert_text 'Welcome! You have signed up successfully.'
    assert_text 'Sign out'
  end
end

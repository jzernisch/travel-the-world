require "application_system_test_case"

class HomePageTest < ApplicationSystemTestCase
  test "visiting the home page" do
    visit "/"

    assert_selector "h1", text: "Home"
  end
end

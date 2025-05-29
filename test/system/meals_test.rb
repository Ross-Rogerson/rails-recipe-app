require "application_system_test_case"

class MealsTest < ApplicationSystemTestCase
  test "Creating a new meal" do
    # When we visit the Meals#index page
    # we expect to see a title with the text "Meals"
    visit meals_path
    assert_selector "h1", text: "Meals"

    # When we click on the link with the text "New meals"
    # we expect to land on a page with the title "New meals"
    click_on "New meals"
    assert_selector "h1", text: "New meals"

    # When we fill in the name input with "Capybara meal"
    # and we click on "Create Meals"
    fill_in "Name", with: "Capybara meals"
    click_on "Create meals"

    # We expect to be back on the page with the title "Meals"
    # and to see our "Capybara meal" added to the list
    assert_selector "h1", text: "Meals"
    assert_text "Capybara meals"
  end
end

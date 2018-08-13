require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit games_url
  #
  #   assert_selector "h1", text: "Game"
  # end
  test  "visiting the page new we obtain a random grid" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test  "when we input hello it sends back that it contains characters that are not in the grid" do
    visit new_url
    fill_in "word", with: "Hello"
    click_on "Send"
    assert_text "characters that are not in the grid"
  end

  test  "when we input d it sends back that it isn't an english word" do
    visit new_url
    fill_in "word", with: "d"
    click_on "Send"
    assert_text "is not an english word"
  end
end

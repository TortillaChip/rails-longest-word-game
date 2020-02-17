require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit games_url
  #
  #   assert_selector "h1", text: "Game"
  # end
  test 'Should have 10 random words' do
    visit new_url
    assert test: 'New Game'
    assert_selector 'li', count: 10
  end

  test 'Score should remain zero, when the word is invalid' do
    visit new_url
    fill_in 'word', with: 'fsufndsunfusndfusdnfuns'
    click_on 'submit'

    assert_text 'Your score is: 0'
  end
end

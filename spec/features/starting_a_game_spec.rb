require 'spec_helper'
require 'board'

feature 'Starting a new game' do
  scenario 'I am asked to enter my name' do
    visit '/'
    click_link 'New Game'
    expect(page).to have_content "What's your name?"
  end

  scenario 'Receives name' do
    visit '/name_input'
    fill_in 'name', with: 'Emily'
    click_button 'New Game'
    expect(page).to have_content "Battleships"
  end

  scenario 'Receives no name' do
    visit '/name_input'
    click_button 'New Game'
    expect(page).to have_content "What's your name?"
  end

  scenario 'Asks you to place boats' do
    $board1 = nil
    visit '/game_setup'
    expect(page).to have_content "place your boats"
  end
end

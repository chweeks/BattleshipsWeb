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
    expect(page).to have_content "Emily's Game"
  end

  scenario 'Receives no name' do
    visit '/name_input'
    click_button 'New Game'
    expect(page).to have_content "What's your name?"
  end

  scenario 'Asks for shot coordinate' do
    visit '/game_setup'
    fill_in 'coord', with: 'A1'
    expect(page).to have_content "Choose coordinate to shoot"
  end
end

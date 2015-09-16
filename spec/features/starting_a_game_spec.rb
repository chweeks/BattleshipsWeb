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

  scenario 'Asks for ship positions' do
    visit '/game_setup'
    expect(page).to have_content "Set Aircraft Carrier position:"
  end

  scenario 'Adds ships to board' do
    visit '/game_setup'
    fill_in 'position1', with: 'A1'
    click_button 'Set'
    expect(page).to have_CSS('div.Ship')
  end
end

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
  scenario 'Creates a grid' do
    visit '/name_input'
    fill_in 'name', with: 'Emily'
    click_button 'New Game'
    expect(page).to have_content '<div'
  end
end

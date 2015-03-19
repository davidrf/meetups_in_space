require 'spec_helper'
require_relative '../../config/application.rb'

feature 'user creates new meetup' do
  # As a user
  # I want to create a meetup
  # So that I can gather a group of people to discuss a given topic
  #
  # Acceptance Criteria:
  # * I must be signed in.
  # * I must supply a name.
  # * I must supply a location.
  # * I must supply a description.
  # * I should be brought to the details page for the meetup after I create it.
  # * I should see a message that lets me know that I have created a meetup successfully.

  scenario 'successfully create meetup' do
    visit '/meetups'
    user = User.create(provider: 'github', uid: rand(1_000_000).to_s, username: 'username', email: 'email@email.com', avatar_url: 'http://url.com')
    login_as(user)

    click_link 'Submit new meetup.'
    fill_in 'Name', with: 'Space Rave'
    fill_in 'Description', with: 'Deadmau5 is going to be playing'
    fill_in 'Location', with: 'Moon Dome'
    click_button 'Create Meetup'

    expect(page).to have_content('Space Rave')
  end

  scenario 'fail to create meetup because not signed in' do
    visit '/meetups'
    click_link 'Submit new meetup.'

    fill_in 'Name', with: 'Space Rave'
    fill_in 'Description', with: 'Deadmau5 is going to be playing'
    fill_in 'Location', with: 'Moon Dome'
    click_button 'Create Meetup'

    expect(page).to have_content('Submit new meetup!')
  end

  scenario 'fail to create meetup because no name given' do
    visit '/meetups'
    user = User.create(provider: 'github', uid: rand(1_000_000).to_s, username: 'username', email: 'email@email.com', avatar_url: 'http://url.com')
    login_as(user)

    click_link 'Submit new meetup.'
    fill_in 'Description', with: 'Deadmau5 is going to be playing'
    fill_in 'Location', with: 'Moon Dome'
    click_button 'Create Meetup'

    expect(page).to have_content('Submit new meetup!')
  end

  scenario 'fail to create meetup because no location given' do
    visit '/meetups'
    user = User.create(provider: 'github', uid: rand(1_000_000).to_s, username: 'username', email: 'email@email.com', avatar_url: 'http://url.com')
    login_as(user)

    click_link 'Submit new meetup.'
    fill_in 'Name', with: 'Space Rave'
    fill_in 'Description', with: 'Deadmau5 is going to be playing'
    click_button 'Create Meetup'

    expect(page).to have_content('Submit new meetup!')
  end

  scenario 'fail to create meetup because no description given' do
    visit '/meetups'
    user = User.create(provider: 'github', uid: rand(1_000_000).to_s, username: 'username', email: 'email@email.com', avatar_url: 'http://url.com')
    login_as(user)

    click_link 'Submit new meetup.'
    fill_in 'Name', with: 'Space Rave'
    fill_in 'Location', with: 'Moon Dome'
    click_button 'Create Meetup'

    expect(page).to have_content('Submit new meetup!')
  end
end

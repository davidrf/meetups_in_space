require 'spec_helper'

feature 'user views list of meetups' do
  # As a user
  # I want to view a list of all available meetups
  # So that I can get together with people with similar interests
  #
  # Acceptance Criteria:
  # * Meetups should be listed alphabetically.
  # * Each meetup listed should link me to the show page for that meetup.

  scenario 'successfully view list meetups' do
    visit '/meetups'

    expect(page).to have_content('Boston Ruby Meetup')
    expect(page).to have_selector('ul#meetups li:first-child a', text: 'A' * 10)
    expect(page).to have_selector('ul#meetups li:last-child a', text: 'Z' * 10)
  end
end

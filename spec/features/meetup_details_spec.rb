require 'spec_helper'

feature 'user views details of a meetup' do
  # As a user
  # I want to view the details of a meetup
  # So that I can learn more about its purpose
  #
  # Acceptance Criteria:
  # * I should see the name of the meetup.
  # * I should see a description of the meetup.
  # * I should see where the meetup is located.

  scenario 'successfully view meetup' do
    visit '/meetups'

    click_link('Boston Ruby Meetup')
    expect(page).to have_content('Boston Ruby Meetup')
    expect(page).to have_content('Boston, MA')
    expect(page).to have_content('Talk about Ruby')
    expect(page).to have_content('davidrf')
  end

  scenario "attempted to view meetup that doesn't exist" do
    visit '/meetups/aksjdfd'

    expect(page).to have_content('Meetup not found')
  end
end

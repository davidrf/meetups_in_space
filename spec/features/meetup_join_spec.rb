require 'spec_helper'

feature 'user joins meetup' do
  # As a user
  # I want to join a meetup
  # So that I can talk to other members of the meetup
  #
  # Acceptance Criteria:
  # * I must be signed in.
  # * From a meetups detail page, I should click a button to join the meetup.
  # * I should see a message that tells let's me know when I have successfully joined a meetup.

  scenario 'successfully joins meetup' do
    visit '/meetups'

    user = User.create(provider: 'github', uid: rand(1_000_000).to_s, username: 'username_join', email: 'email@email.com', avatar_url: 'http://url.com')
    login_as(user)

    click_link('Boston Ruby Meetup')
    click_button('Join this meetup')
    expect(page).to have_content('Successfully joined!')
    expect(page).to have_content('Boston Ruby Meetup')
    expect(page).to have_content('Boston, MA')
    expect(page).to have_content('Talk about Ruby')
    expect(page).to have_content('username_join')
  end

  scenario 'fail join meetup because not signed in' do
    visit '/meetups'

    click_link('Boston Ruby Meetup')
    click_button('Join this meetup')
    expect(page).to have_no_content('Successfully joined!')
    expect(page).to have_content('Error: not successfully joined.')
    expect(page).to have_content('Boston Ruby Meetup')
    expect(page).to have_content('Boston, MA')
    expect(page).to have_content('Talk about Ruby')
  end

  scenario "fail join meetup because meetup doesn't exist" do
    user = User.create(provider: 'github', uid: rand(1_000_000).to_s, username: 'username_join', email: 'email@email.com', avatar_url: 'http://url.com')
    login_as(user)

    visit '/meetups/a'
    expect(page).to have_content('Meetup not found')
    click_button('Join this meetup')
    expect(page).to have_no_content('Successfully joined!')
    expect(page).to have_content('Error: not successfully joined.')
  end
end

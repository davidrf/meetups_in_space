require 'pry'
require 'rspec'
require 'capybara/rspec'

require_relative '../app.rb'

set :environment, :test

Capybara.app = Sinatra::Application

OmniAuth.config.test_mode = true

def login_as(user)
  mock_omni_auth_for(user)
  visit "/auth/#{user.provider}"
  expect(page).to have_content("You're now signed in as #{user.username}!")
end

def mock_omni_auth_for(user)
  mock_options = {
    uid: user.uid,
    provider: user.provider,
    info: {
      nickname: user.username,
      email: user.email,
      image: user.avatar_url
    }
  }
  OmniAuth.config.add_mock(user.provider.to_sym, mock_options)
end

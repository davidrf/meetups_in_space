require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'omniauth-github'

require_relative 'config/application'

Dir['app/**/*.rb'].each { |file| require_relative file }

helpers do
  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find(user_id) if user_id.present?
  end

  def signed_in?
    current_user.present?
  end
end

def set_current_user(user)
  session[:user_id] = user.id
end

def authenticate!
  unless signed_in?
    flash[:notice] = 'You need to sign in if you want to do that!'
    redirect '/'
  end
end

get '/' do
  redirect '/meetups'
end

get '/meetups' do
  @meetups = Meetup.order(:name)
  erb :index
end

get '/meetups/new' do
  meetup = Meetup.new
  erb :newmeetup, locals: { meetup: meetup }
end

post '/meetups' do
  meetup = Meetup.new(params[:meetup])
  if meetup.save && session[:user_id]
    redirect "meetups/#{meetup.id}"
  else
    erb :newmeetup, locals: { meetup: meetup }
  end
end

post '/meetups/:id/join' do
  if Meetup.exists?(params[:id])
    joined_meetup = Membership.new(user_id: session[:user_id], meetup_id: params[:id])
    if joined_meetup.save
      redirect("/meetups/#{params[:id]}?joined=true")
    end
  end
  redirect("/meetups/#{params[:id]}?joined=false")
end

get '/meetups/:id' do
  begin
    @meetup = Meetup.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    @meetup = Meetup.new(
      id: params[:id], users: [], name: 'Meetup not found', location: '', description: ''
    )
  end

  @users = @meetup.users
  erb :show
end

get '/auth/github/callback' do
  auth = env['omniauth.auth']

  user = User.find_or_create_from_omniauth(auth)
  set_current_user(user)
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = 'You have been signed out.'

  redirect '/'
end

get '/example_protected_page' do
  authenticate!
end

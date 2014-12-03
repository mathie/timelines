require 'rails_helper'

RSpec.feature 'Managing user sessions' do
  scenario 'Finding the sign in button' do
    visit '/'

    click_on 'Sign in'

    expect(current_path).to eq('/session/new')
  end

  scenario 'Finding the sign up button on the home page' do
    visit '/'

    click_on 'Sign up'

    expect(current_path).to eq('/session/new')
  end

  scenario 'Finding the Google sign in button' do
    visit '/session/new'

    expect(page).to have_link('Sign in with Google')
  end

  scenario 'Finding the Google sign in button' do
    visit '/session/new'

    expect(page).to have_link('Sign in with GitHub')
  end

  feature 'Signing in with GitHub' do
    scenario 'As a new user'
    scenario 'As an existing user'
  end

  feature 'Signing in with Google' do
    scenario 'As a new user'
    scenario 'As an existing user'
  end

  scenario 'Signing out'
end

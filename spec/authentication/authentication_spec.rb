require 'rails_helper'

RSpec.describe 'Siging Up', type: :feature do
  let(:user) { User.new(username: 'tarly', fullname: 'truly') }
  scenario 'Sign up with valid inputs' do
    visit signup_path
    click_on 'Sign up'
    fill_in 'username', with: user.username
    
    click_on 'Sign up'
    sleep(3)
    visit home_path
    expect(page).to have_content('Login')
  end

  scenario 'Sign up with invalid inputs' do
    visit signup_path
    fill_in 'username', with: ''
    click_on 'Sign up'
    sleep(3)
    visit root_path
    expect(page).to_not have_content('Username does not exist in our database')
  end
end

RSpec.describe 'Loggin In', type: :feature do
  let(:user) { User.create(username: 'mrigorir') }
  scenario 'Log in with invalid inputs' do
    visit login_path
    fill_in 'username', with: user.username
    click_on 'Login'
    sleep(3)
    expect(page).to_not have_content('Tweets')
  end

  scenario 'Log in with invalid inputs' do
    visit login_path
    fill_in 'username', with: user.username
    click_on 'Login'
    sleep(3)
    expect(page).to have_content('Username does not exist in our database')
  end
end

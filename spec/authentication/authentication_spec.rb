require 'rails_helper'

RSpec.describe 'Siging Up', type: :feature do
  let(:user) { User.new(username: 'tarly', fullname: 'truly') }
  scenario 'Sign up with valid inputs' do
    visit login_path
    click_on 'Sign up'
    find(:css, '#new_fullname', visible: false).set user.fullname
    find(:css, '#new_username', visible: false).set user.username
    click_on 'Sign up'
    sleep(3)
    visit home_path
    expect(page).to have_content('truly')
  end

  scenario 'Sign up with invalid inputs' do
    visit login_path
    click_on 'Sign up'
    find(:css, '#new_fullname', visible: false).set ' '
    find(:css, '#new_username', visible: false).set user.username
    click_on 'Sign up'
    expect(page).to have_content('Fullname can\'t be blank')
  end
end

RSpec.describe 'Loggin In', type: :feature do
  let(:user) { User.create(username: 'mrigorir') }
  scenario 'Log in with invalid inputs' do
    visit login_path
    find(:css, '#login_username', visible: false).set user.username
    click_on 'Login'
    sleep(3)
    expect(page).to_not have_content('Tweets')
  end

  scenario 'Log in with invalid inputs' do
    visit login_path
    find(:css, '#login_username', visible: false).set ' '
    click_on 'Login'
    sleep(3)
    expect(page).to have_content('Username does not exist in our database')
  end
end

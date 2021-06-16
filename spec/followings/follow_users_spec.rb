require 'rails_helper'

RSpec.describe 'User login the app', type: :feature do
  before :each do
    User.create(username: 'user', fullname: 'sama1', id: 1)
    User.create(username: 'user2', fullname: 'sama2', id: 2)
    User.create(username: 'user3', fullname: 'sama3', id: 3)
    User.create(username: 'user4', fullname: 'sama4', id: 4)
    User.create(username: 'user5', fullname: 'sama5', id: 5)
    @user = User.find(1)
    @user2 = User.find(5)
    Opinion.create(author_id: 1, text: 'tweet1')
    visit login_path
    find(:css, '#login_username', visible: false).set 'user'
    click_button 'Login'
    visit home_path
  end

  scenario 'Users to follow are shown on home page' do
    expect(page).to have_content('sama5')
  end

  scenario 'Follow a user' do
    find(:css, 'h6 a', text: 'sama5').click
    find(:css, '#follow_user').click
    expect(page).to have_text('Great, user followed!')
  end

  scenario 'unfollow a user' do
    if @user.already_follow?(@user2)
      find(:css, '#not_following').click
      expect(page).to have_text('You are not following this user anymore!')
    end
  end
end

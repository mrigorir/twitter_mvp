require 'rails_helper'

RSpec.describe 'Opinion features', type: :feature do
  before :each do
    User.create(username: 'user10', fullname: 'sama10', id: 20)
    visit login_path
    find(:css, '#login_username', visible: false).set 'user10'
    click_button 'Login'
    visit home_path
    expect(page).to have_content('Tweets')
  end

  describe 'opinion features' do
    it 'creates opinion message' do
      find(:css, '#opinion_text', visible: false).set 'Mrigorir!'
      click_on('Tweet it!')
      expect(page).to have_content('Mrigorir!')
    end
  end
end

require 'rails_helper'

RSpec.describe Follow, type: :model do
  let(:user1) { User.new(username: 'user50', fullname: 'name1') }
  let(:user2) { User.new(username: 'user27', fullname: 'name2') }

  describe 'ActiveRecord associations' do
    it { should belong_to(:follower).class_name('User') }
    it { should belong_to(:followed_user).class_name('User') }
  end

  describe 'validates Follow associations' do
    it 'validates if user is added to users followings' do
      user1.save
      user2.save
      Follow.create(follower_id: user1.id, following_id: user2.id)
      expect(user1.already_follow?(user2.id)).to eql(true)
    end
  end
end

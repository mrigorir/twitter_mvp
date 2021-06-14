require 'rails_helper'

RSpec.describe Opinion, type: :model do
  let(:user1) { User.new(username: 'user1', fullname: 'name1') }
  let(:user2) { User.new(username: 'user2', fullname: 'name2') }
  let(:opinion1) { Opinion.create(author_id: user1.id, text: 'Go ahead, tweet something for me!') }

  it { should validate_presence_of(:text) }
  it { should validate_length_of(:text).is_at_most(300) }

  describe 'ActiveRecord associations' do
    it { should belong_to(:author).class_name('User') }
  end
end

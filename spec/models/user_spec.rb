require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:fullname) }

  it { should validate_length_of(:username).is_at_most(10).on(:create) }
  it { should validate_length_of(:fullname).is_at_most(60).on(:create) }
  it { should validate_uniqueness_of(:username) }
  
  describe 'ActiveRecord associations' do
    it { should have_many(:created_opinions).class_name('Opinion') }
    it { should have_many(:followers).class_name('Follow') }
    it { should have_many(:user_followers).source('follower') }
    it { should have_many(:followings).class_name('Follow') }
    it { should have_many(:user_followings).source('following') }
  end
end


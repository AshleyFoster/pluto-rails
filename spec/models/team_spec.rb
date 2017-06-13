require 'rails_helper'

RSpec.describe Team, type: :model do
  context 'validations' do
    subject { FactoryGirl.build(:team) }

    it do
      should validate_presence_of(:name)
      should validate_uniqueness_of(:name).case_insensitive
      should validate_presence_of(:time)
      should have_many(:team_invites)
      should have_many(:users)
      should have_many(:standups)
    end
  end
end

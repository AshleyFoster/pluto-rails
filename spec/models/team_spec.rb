require 'rails_helper'

RSpec.describe Team, type: :model do
  context 'validations' do
    subject { FactoryGirl.build(:team) }

    it do
      should belong_to(:user)
      should validate_presence_of(:name)
      should validate_uniqueness_of(:name).case_insensitive
      should validate_presence_of(:time)
    end
  end
end

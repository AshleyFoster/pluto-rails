require 'rails_helper'

RSpec.describe TeamMemberCreator do
  describe 'with valid params' do
    it 'sends team invite email' do
      user = create(:user)
      team = create(:team)
      team_invite_params = attributes_for(:team_invite)
      allow(TeamInviteMailer).to receive(:team_invite).and_call_original

      creator = TeamMemberCreator.new(user, team, team_invite_params)
      creator.save

      expect(TeamInviteMailer).to have_received(:team_invite).once
    end

    it 'returns true' do
      user = create(:user)
      team = create(:team)
      team_invite_params = attributes_for(:team_invite)

      creator = TeamMemberCreator.new(user, team, team_invite_params)

      expect(creator.save).to be
    end
  end

  describe 'with invalid params' do
    it 'returns false' do
      user = create(:user)
      team = create(:team)

      creator = TeamMemberCreator.new(user, team, {})

      expect(creator.save).to be false
    end
  end
end

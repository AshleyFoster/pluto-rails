require "rails_helper"

RSpec.describe TeamInviteMailer, type: :mailer do
  describe 'new_user_invite' do
    it 'renders the email' do
      email = "pam@art.school"
      user = FactoryGirl.create(:user, name: "Michael")
      team = FactoryGirl.create(:team, name: "Dunder-Mifflin: Sales")
      team_invite = FactoryGirl.create(
        :team_invite,
        email: email,
        team: team,
        user: user
      )
      invite = TeamInviteMailer.team_invite(team_invite).deliver_now

      expect(invite.subject).to eq(
        "Join #{team_invite.team.name} on fromPluto"
      )
    end

    it 'renders the reciever email' do
      email = "pam@art.school"
      user = FactoryGirl.create(:user, name: "Michael")
      team = FactoryGirl.create(:team, name: "Dunder-Mifflin: Sales")
      team_invite = FactoryGirl.create(
        :team_invite,
        email: email,
        team: team,
        user: user
      )
      invite = TeamInviteMailer.team_invite(team_invite).deliver_now

      expect(invite.to).to eq(["pam@art.school"])
    end

    it 'renders the body of the email' do
      email = "pam@art.school"
      user = FactoryGirl.create(:user, name: "Michael")
      team = FactoryGirl.create(:team, name: "Dunder-Mifflin: Sales")
      team_invite = FactoryGirl.create(
        :team_invite,
        email: email,
        team: team,
        user: user
      )
      invite = TeamInviteMailer.team_invite(team_invite).deliver_now

      expect(invite.body.encoded).to match("Click")
    end
  end
end

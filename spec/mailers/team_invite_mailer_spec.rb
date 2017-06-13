require "rails_helper"

RSpec.describe TeamInviteMailer, type: :mailer do
  describe 'new_user_invite' do
    it 'renders the email' do
      email = "Pam@art.school"
      user = FactoryGirl.create(:user, name: "Michael")
      team = FactoryGirl.create(:team, name: "Dunder-Mifflin: Sales")
      sender = FactoryGirl.create(
        :team_user,
        team: team,
        user: user,
        role: TeamUser::OWNER
      )
      team_invite = FactoryGirl.create(
        :team_invite,
        email: email,
        team: team,
        team_user: sender
      )
      invite = TeamInviteMailer.new_user_invite(team_invite).deliver_now

      expect(invite.subject).to eq(
        "#{team_invite.team_user.user.name} wants you to join #{team_invite.team.name} on fromPluto"
      )
    end

    it 'renders the reciever email' do
      email = "Pam@art.school"
      user = FactoryGirl.create(:user, name: "Michael")
      team = FactoryGirl.create(:team, name: "Dunder-Mifflin: Sales")
      sender = FactoryGirl.create(
        :team_user,
        team: team,
        user: user,
        role: TeamUser::OWNER
      )
      team_invite = FactoryGirl.create(
        :team_invite,
        email: email,
        team: team,
        team_user: sender
      )
      invite = TeamInviteMailer.new_user_invite(team_invite).deliver_now

      expect(invite.to).to eq(["Pam@art.school"])
    end

    it 'renders the sender email' do
      email = "Pam@art.school"
      user = FactoryGirl.create(:user, name: "Michael")
      team = FactoryGirl.create(:team, name: "Dunder-Mifflin: Sales")
      sender = FactoryGirl.create(
        :team_user,
        team: team,
        user: user,
        role: TeamUser::OWNER
      )
      team_invite = FactoryGirl.create(
        :team_invite,
        email: email,
        team: team,
        team_user: sender
      )
      invite = TeamInviteMailer.new_user_invite(team_invite).deliver_now

      expect(invite.from).to eq(["noreply@frompluto.co"])
    end
  end

  describe 'existing_user_invite' do
    it 'renders the email' do
      existing_user = FactoryGirl.create(:user, name: "Darryl", email: "Darryl@DM.warehouse")
      manager = FactoryGirl.create(:user, name: "Michael")
      team = FactoryGirl.create(:team, name: "Dunder-Mifflin: Sales")
      sender = FactoryGirl.create(
        :team_user,
        team: team,
        user: manager,
        role: TeamUser::OWNER
      )
      team_invite = FactoryGirl.create(
        :team_invite,
        email: (existing_user.email),
        team: team,
        team_user: sender
      )
      invite = TeamInviteMailer.existing_user_invite(team_invite).deliver_now

      expect(invite.subject).to eq(
        "#{team_invite.team_user.user.name} has added you to #{team_invite.team.name}"
      )
    end

    it 'renders the reciever email' do
      existing_user = FactoryGirl.create(:user, name: "Darryl", email: "Darryl@DM.warehouse")
      manager = FactoryGirl.create(:user, name: "Michael")
      team = FactoryGirl.create(:team, name: "Dunder-Mifflin: Sales")
      sender = FactoryGirl.create(
        :team_user,
        team: team,
        user: manager,
        role: TeamUser::OWNER
      )
      team_invite = FactoryGirl.create(
        :team_invite,
        email: (existing_user.email),
        team: team,
        team_user: sender
      )
      invite = TeamInviteMailer.existing_user_invite(team_invite).deliver_now

      expect(invite.to).to eq(["darryl@dm.warehouse"])
    end

    it 'renders the sender email' do
      existing_user = FactoryGirl.create(:user, name: "Darryl", email: "Darryl@DM.warehouse")
      manager = FactoryGirl.create(:user, name: "Michael")
      team = FactoryGirl.create(:team, name: "Dunder-Mifflin: Sales")
      sender = FactoryGirl.create(
        :team_user,
        team: team,
        user: manager,
        role: TeamUser::OWNER
      )
      team_invite = FactoryGirl.create(
        :team_invite,
        email: (existing_user.email),
        team: team,
        team_user: sender
      )
      invite = TeamInviteMailer.existing_user_invite(team_invite).deliver_now
      expect(invite.from).to eq(["noreply@frompluto.co"])
    end
  end
end

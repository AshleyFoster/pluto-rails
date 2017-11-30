# Preview all emails at http://localhost:3000/rails/mailers/team_invite_mailer
class TeamInviteMailerPreview < ActionMailer::Preview
  def team_invite
    team_invite = TeamInvite.first || FactoryGirl.build(:team)
    TeamInviteMailer.team_invite(team_invite)
  end
end

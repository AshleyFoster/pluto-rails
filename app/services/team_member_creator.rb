class TeamMemberCreator
  include ActiveModel::Validations
  attr_reader :team_invite

  validates_presence_of :email

  def initialize(user, team, team_invite_params)
    @team_invite = team.team_invites.build(team_invite_params)
    @team_invite.user = user
  end

  def errors
    @team_invite.errors
  end

  def save
    if @team_invite.save
      TeamInviteMailer.team_invite(
        @team_invite,
      ).deliver_later

      true
    else
      false
    end
  end
end

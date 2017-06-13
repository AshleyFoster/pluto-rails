class TeamInviteMailer < ApplicationMailer
  default from: "noreply@frompluto.co"

  def team_invite(team_invite)
    @team_invite = team_invite

    mail(
      to: @team_invite.email,
      subject: "#{@team_invite.team_user.user.name} wants you to join #{@team_invite.team.name} on fromPluto"
    )
  end
end

class TeamInviteMailer < ApplicationMailer
  default from: "noreply@frompluto.co"

  def team_invite(team_invite)
    @team_invite = team_invite

    mail(
      to: @team_invite.email,
      subject: "Join #{@team_invite.team.name} on fromPluto"
    ) do |format|
      format.html
      format.text
    end
  end
end

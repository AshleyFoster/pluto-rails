class TeamInvitesController < ApplicationController
  layout 'team'
  before_action :find_team

  def index
    @team_invite = @team.team_invites.build
    @team_invites = @team.team_invites.all
  end

  def create
    @team_invites = @team.team_invites.all
    team_member_creator = TeamMemberCreator.new(current_user, @team, team_invite_params)

    if team_member_creator.save
      flash[:notice] = "User has been invited"
      redirect_to team_team_invites_path
    else
      @team_invite = team_member_creator.team_invite
      flash[:alert] = "Could not invite user"
      render 'index'
    end
  end

  def destroy
    @team_invite = @team.team_invites.find(params[:id])
    @team_invite.destroy
    flash[:notice] = "Invitation has been removed"
    redirect_to team_team_invites_path
  end

  private

  def team_invite_params
    params.require(:team_invite).permit(:email, :token)
  end

  def find_team
    @team = Team.find(params[:team_id])
  end
end

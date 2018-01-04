class TeamInvitesController < ApplicationController
  layout 'team', except: [:show]
  before_action :find_team, except: [:show]

  def index
    @team_invite = @team.team_invites.build
    @team_invites = @team.team_invites.all
    @team_members = team_members
  end

  def show
    @team_invite = TeamInvite.find_by!(token: params[:token])
    @team = @team_invite.team
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

  def update
    @team_invite = TeamInvite.find(params[:id])
    @team = @team_invite.team

    if accepted?
      TeamUser.create!(user: current_user, team: @team_invite.team, role: TeamUser::MEMBER)
      @team_invite.destroy
      flash[:notice] = "Welcome to the team!"
      redirect_to team_standups_path(@team)
    else
      @team_invite.destroy
      flash[:notice] = "You have declined to join"
      redirect_to teams_path
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

  def accepted?
    params[:commit] == "Accept"
  end

  def team_members
    @team.users.order('created_at')
  end
end

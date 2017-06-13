class TeamsController < ApplicationController
  def index
    @teams = current_user.teams
  end

  def show
    team = current_user.teams.find(params[:id])
    redirect_to team_standups_path(team)
  end

  def new
    @team = Team.new
  end

  def create
    team_creator = TeamCreator.new(current_user, team_params)

    if team_creator.save
      redirect_to teams_path, notice: "Team created!"
    else
      @team = team_creator.team
      flash.now[:alert] = "Unable to create team"
      render 'new'
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])

    if @team.update_attributes(team_params)
      redirect_to teams_path, notice: "Team Updated"
    else
      flash.now[:alert] = "Unable to update team"
      render 'edit'
    end
  end


  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    redirect_to teams_path, notice: "Team deleted"
  end

  private

  def team_params
    params.require(:team).permit(:name, :days_of_week, :time)
  end
end

class TeamsController < ApplicationController
  def index
    @teams = current_user.teams
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.user = current_user

    if @team.save
      redirect_to teams_path, notice: "Team created!"
    else
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

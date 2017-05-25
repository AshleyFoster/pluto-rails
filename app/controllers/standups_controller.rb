class StandupsController < ApplicationController
  before_action :find_team

  def index
    @standup = @team.standups.build
    @standup.blockers.build
    @standups = @team.standups.where("created_at >= ?", Time.now.beginning_of_day)
    @todays_standup = find_todays_standup
  end

  def create
    @standup = @team.standups.build(standup_params)
    @standup.user = current_user

    if @standup.save
      redirect_to team_standups_path, notice: "Standup created!"
    else
      flash.now[:alert] = "Unable to create Standup"
      render 'index'
    end
  end

  private

  def find_team
    @team = Team.find(params[:team_id])
  end

  def standup_params
    params.require(:standup).permit(:body, blockers_attributes: [:body])
  end

  def find_todays_standup
    current_user
      .standups
      .where(team: @team)
      .where("created_at >= ?", Time.now.beginning_of_day)
      .first
  end
end

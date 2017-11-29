class StandupsController < ApplicationController
  layout 'team'

  before_action :find_team
  before_action :get_and_set_date

  def index
    @standup = @team.standups.build
    @standup.blockers.build

    if params[:date]
      date = Date.strptime(params[:date], "%m-%d-%Y")
      @standups = @team.standups
        .where("created_at >= ? and created_at <= ?", date.beginning_of_day, date.end_of_day)
    else
      @standups = @team.standups.where("created_at >= ?", @todays_date.beginning_of_day)
    end

    @todays_standup = find_todays_standup

    @last_day_with_standups = find_last_day_with_standups
    @next_day_with_standups = find_next_day_with_standups
  end

  def create
    @standup = @team.standups.build(standup_params)
    @standup.user = current_user

    if @standup.save
      redirect_to team_standups_path, notice: "Standup created!"
    else
      @standup.blockers.build if @standup.blockers.empty?
      flash.now[:alert] = "Unable to create Standup"
      render 'index'
    end
  end

  private

  def find_team
    @team = Team.find(params[:team_id])
  end

  def get_and_set_date
    if params[:date]
      @todays_date = Date.strptime(params[:date], "%m-%d-%Y")
    else
      @todays_date = Date.today
    end
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

  def find_last_day_with_standups
    @team.standups
      .where("created_at < ?", @todays_date.beginning_of_day)
      .order(:created_at)
      .limit(1)
      .first
      .try(:created_at)
  end

  def find_next_day_with_standups
    @team.standups
      .where("created_at > ?", @todays_date.end_of_day)
      .order(:created_at)
      .limit(1)
      .first
      .try(:created_at)
  end
end

class TeamCreator
  attr_reader :team
  def initialize(user, team_params)
    @user = user
    @team = Team.new(team_params)
  end

  def save
    ActiveRecord::Base.transaction do
      begin
        @team.save!
        TeamUser.create!(user: @user, team: @team, role: TeamUser::OWNER)
        true
      rescue
        false
      end
    end
  end

  private

  def create_team_user
    TeamUser::OWNER
  end
end

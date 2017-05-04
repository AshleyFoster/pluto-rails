class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :get_teams_for_dropdown

  def get_teams_for_dropdown
    if current_user
      @dropdown_teams = current_user.teams
    end
  end
end

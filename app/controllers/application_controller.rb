class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :get_teams_for_dropdown
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def get_teams_for_dropdown
    if current_user
      @dropdown_teams = current_user.teams
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :email, :password, :password_confirmation)
    end
  end
end

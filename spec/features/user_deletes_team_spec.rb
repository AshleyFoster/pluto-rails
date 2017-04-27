require 'rails_helper'

RSpec.feature "user deletes a team" do
  scenario "destroys a team for the user" do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    team = FactoryGirl.create(:team, name: "Team 1", user: user)
    visit edit_team_path(team)

    click_link 'delete'

    expect(page).to have_content 'Team deleted'
    expect(page).not_to have_content('Team 1')
  end
end

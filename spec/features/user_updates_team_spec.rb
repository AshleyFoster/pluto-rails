require 'rails_helper'

RSpec.feature "user updates a team" do
  scenario "updates a team's attributes for the user" do
    user = FactoryGirl.create(:user)
    team = FactoryGirl.create(:team, name: "Team 1", user: user)

    login_as(user, scope: :user)
    visit edit_team_path(team)

    fill_in 'Name', :with => 'Team Infinity'
    click_button 'Update Team'

    expect(page).to have_content 'Team Updated'
    expect(page).to have_content 'Team Infinity'
    expect(page).not_to have_content('Team 1')
  end
end

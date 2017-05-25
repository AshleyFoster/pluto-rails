require 'rails_helper'

RSpec.feature "user deletes a team" do
  scenario "destroys a team for the user" do
    user = FactoryGirl.create(:user)
    team = FactoryGirl.create(:team, name: "Team 1", user: user)

    login_as(user, :scope => :user)
    visit edit_team_path(team)

    click_link 'delete'
    alert = page.driver.browser.switch_to.alert
    alert.accept

    expect(page).to have_content 'Team deleted'
    expect(page).not_to have_content('Team 1')
  end
end

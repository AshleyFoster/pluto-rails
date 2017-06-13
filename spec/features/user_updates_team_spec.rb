require 'rails_helper'

RSpec.feature "user updates a team" do
  scenario "allows team's owner to update team attributes" do
    user = create(:user)
    team = create(:team, name: "Team 1")
    owner = create(:team_user, team: team, user: user, role: TeamUser::OWNER)

    login_as(user, scope: :user)
    visit '/teams'

    find('.team', text: 'Team 1').click
    fill_in 'Name', :with => 'Team Infinity'
    # click_button 'Update Team'

    # expect(page).to have_content 'Team Updated'
    # expect(page).to have_content 'Team Infinity'
    # expect(page).not_to have_content('Team 1')
  end
end

require "rails_helper"

RSpec.feature "delete a team invite" do
  scenario "a team owner can delete a team invite" do
    user = FactoryGirl.create(:user, name: "Michael")
    team = FactoryGirl.create(:team, name: "Dunder-Mifflin")
    team_user = FactoryGirl.create(
      :team_user,
      team: team,
      user: user,
      role: TeamUser::OWNER
    )
    login_as(user, scope: :user)
    visit team_path(team)

    expect(page).to have_content "members"
    click_link "members"
    team_invite = FactoryGirl.create(
      :team_invite,
      team: team,
      user: user,
      email: "jim@dundermifflin.org"
    )
    visit team_team_invites_path(team)
    click_link "Cancel Invite"

    expect(page).to have_content "Invitation has been removed"
    expect(page).not_to have_content "Jim@dundermifflin.org"
  end
end

require "rails_helper"

RSpec.feature "invite a new team member" do
  scenario "a team member cannot invite a new team member" do
    user = FactoryGirl.create(:user, name: "Dwight")
    team = FactoryGirl.create(:team, name: "Dunder-Mifflin")
    team_user = FactoryGirl.create(
      :team_user,
      team: team,
      user: user,
      role: TeamUser::MEMBER
    )
    login_as(user, scope: :user)
    visit team_path(team)

    expect(page).to_not have_content "members"
  end

  scenario "a team owner can invite a new team member" do
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
    fill_in(
      "team_invite_email",
      with: "Jim@dundermifflin.org"
    ).native.send_keys(:return)

    expect(page).to have_content "User has been invited"
    expect(page).to have_content "Jim@dundermifflin.org"
  end

  scenario "a team owner can't invite a team member who has already been invited" do
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
    fill_in(
      "team_invite_email",
      with: "Jim@dundermifflin.org"
    ).native.send_keys(:return)

    expect(page).to have_content "User has been invited"
    expect(page).to have_content "Jim@dundermifflin.org"

    fill_in(
      "team_invite_email",
      with: "Jim@dundermifflin.org"
    ).native.send_keys(:return)

    expect(page).to have_content "Email has already been taken"
    expect(page).to have_content "Jim@dundermifflin.org"
  end
end

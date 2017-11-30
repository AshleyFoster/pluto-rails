require "rails_helper"

RSpec.feature "accept or decline team invite" do
  background do
    owner = FactoryGirl.create(:user)
    team = FactoryGirl.create(:team)
    team_user = FactoryGirl.create(
      :team_user,
      user: owner,
      role: TeamUser::OWNER,
      team: team
    )
    @user = FactoryGirl.create(:user)
    @team_invite = FactoryGirl.create(
      :team_invite,
      email: @user.email,
      team: team,
      user: owner
    )
    @token = @team_invite.token
  end

  scenario "user accepts team invite" do
    visit "/"
    login_as(@user, :scope => :user)
    visit team_team_invite_path(@team_invite.team.id, @team_invite.id, token: @token)
    click_button("Accept")

    expect(page).to have_content("Welcome to the team!")
  end

  scenario "user declines team invite" do
    visit "/"
    login_as(@user, :scope => :user)
    visit team_team_invite_path(@team_invite.team.id, @team_invite.id, token: @token)
    click_button("Decline")

    expect(page).to have_content("You have declined to join")
  end
end

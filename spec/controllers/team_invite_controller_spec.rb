require "rails_helper"

describe TeamInvitesController, type: :controller do
  describe "POST #create" do

    it "sends an invite email" do
      user = FactoryGirl.create(:user)
      team = FactoryGirl.build(:team, name: "Best")
      team_user = FactoryGirl.create(:team_user, user: user, team: team, role: TeamUser::OWNER)

      visit("/")
      sign_in user

      # expect {
      #   perform_enqueued_jobs do
      #     post :create, params: { team_id: team.id, new_team_invite: { email: "foo@bar.net" }}
      #   end
      # }.to change{ActionMailer::Base.deliveries.count}.by(1)
    end
  end
end

class AddFeildsToTeamInvites < ActiveRecord::Migration[5.1]
  def change
    add_column :team_invites, :user_id, :integer
  end
end

class RemoveUserIdFromTeams < ActiveRecord::Migration[5.1]
  def change
    remove_reference :teams, :user, index: true
  end
end

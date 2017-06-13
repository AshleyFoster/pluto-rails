class CreateTeamInvites < ActiveRecord::Migration[5.1]
  def change
    create_table :team_invites do |t|
      t.string :email, null: false
      t.string :token, null: false
      t.references :team, index: true

      t.timestamps
    end
  end
end

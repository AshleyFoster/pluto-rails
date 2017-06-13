class CreateTeamUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :team_users do |t|
      t.references :user, index: true, nil: false
      t.references :team, index: true, nil: false
      t.string :role, null: false

      t.timestamps
    end
  end
end

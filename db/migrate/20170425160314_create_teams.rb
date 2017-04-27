class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name, :unique => true
      t.references :user, index: true
      t.time :time, null: false

      t.timestamps
    end
    add_column :teams, :days_of_week, :integer, default: '{1,2,3,4,5}', array: true
  end
end

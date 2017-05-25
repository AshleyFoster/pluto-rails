class CreateBlockers < ActiveRecord::Migration[5.1]
  def change
    create_table :blockers do |t|
      t.text :body
      t.references :standup, index: true, nil: false

      t.timestamps
    end
  end
end

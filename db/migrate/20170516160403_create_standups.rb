class CreateStandups < ActiveRecord::Migration[5.1]
  def change
    create_table :standups do |t|
      t.text :body
      t.references :user, index: true, nil: false
     t.references :team, index: true, nil: false

      t.timestamps
    end
  end
end

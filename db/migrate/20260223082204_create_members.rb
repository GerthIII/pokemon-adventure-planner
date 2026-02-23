class CreateMembers < ActiveRecord::Migration[8.1]
  def change
    create_table :members do |t|
      t.string :ability
      t.string :nature
      t.string :held_item
      t.string :move_1
      t.string :move_2
      t.string :move_3
      t.string :move_4
      t.references :team, null: false, foreign_key: true
      t.references :pokemon, null: false, foreign_key: true

      t.timestamps
    end
  end
end

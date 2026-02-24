class CreatePlaythroughs < ActiveRecord::Migration[8.1]
  def change
    create_table :playthroughs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :game_version

      t.timestamps
    end
  end
end

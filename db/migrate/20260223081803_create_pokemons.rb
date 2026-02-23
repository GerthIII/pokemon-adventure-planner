class CreatePokemons < ActiveRecord::Migration[8.1]
  def change
    create_table :pokemons do |t|
      t.text :name
      t.string :type_1
      t.string :type_2

      t.timestamps
    end
  end
end

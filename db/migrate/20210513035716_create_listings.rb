class CreateListings < ActiveRecord::Migration[6.1]
  def change
    create_table :listings do |t|
      t.string :name
      t.decimal :price
      t.string :description
      t.text :ingredients
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

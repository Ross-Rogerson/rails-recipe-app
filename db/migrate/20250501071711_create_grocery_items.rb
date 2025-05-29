class CreateGroceryItems < ActiveRecord::Migration[8.0]
  def change
    create_table :grocery_items do |t|
      t.string :name, null: false
      t.integer :quantity, precision: 5, null: false
      t.integer :quantity_unit, null: false
      t.decimal :price, precision: 5, scale: 2, null: false
      t.decimal :unit_price, precision: 5, scale: 2
      t.integer :supermarket, null: false
      t.boolean :has_plastic_packaging, null: false
      
      t.references :user, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true

      t.index [:name, :supermarket, :quantity, :quantity_unit], unique: true, name: "index_grocery_items_on_unique_combination"

      t.timestamps
    end
  end
end

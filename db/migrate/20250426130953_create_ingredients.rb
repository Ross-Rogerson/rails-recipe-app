class CreateIngredients < ActiveRecord::Migration[8.0]
  def change
    create_table :ingredients do |t|
      t.string :name, null: false
      t.decimal :calories_per_100g, null: false, precision: 8, scale: 2
      t.decimal :saturated_fat_per_100g, null: false, precision: 8, scale: 2
      t.decimal :unsaturated_fat_per_100g, null: false, precision: 8, scale: 2
      t.decimal :carbohydrates_per_100g, null: false, precision: 8, scale: 2
      t.decimal :sugars_per_100g, null: false, precision: 8, scale: 2
      t.decimal :fibre_per_100g, null: false, precision: 8, scale: 2
      t.decimal :protein_per_100g, null: false, precision: 8, scale: 2
      t.decimal :salt_per_100g, null: false, precision: 8, scale: 2
      t.boolean :vegetarian, null: false
      t.integer :category, null: false

      t.index :name, unique: true

      t.timestamps
    end
  end
end

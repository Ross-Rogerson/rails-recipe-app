class CreateMeals < ActiveRecord::Migration[7.0]
  def change
    create_table :meals do |t|
      t.string :name, null: false
      t.integer :portions, null: false
      t.decimal :calories_per_portion, precision: 8, scale: 2, null: false
      t.decimal :saturated_fat_per_portion, precision: 8, scale: 2, null: false
      t.decimal :unsaturated_fat_per_portion, precision: 8, scale: 2, null: false
      t.decimal :carbohydrates_per_portion, precision: 8, scale: 2, null: false
      t.decimal :sugars_per_portion, precision: 8, scale: 2, null: false
      t.decimal :fibre_per_portion, precision: 8, scale: 2, null: false
      t.decimal :protein_per_portion, precision: 8, scale: 2, null: false
      t.decimal :salt_per_portion, precision: 8, scale: 2, null: false

      t.timestamps
    end
  end
end
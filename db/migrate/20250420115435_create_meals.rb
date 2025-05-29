class CreateMeals < ActiveRecord::Migration[7.0]
  def change
    create_table :meals do |t|
      t.string :name, null: false
      # t.float :calories
      # t.float :saturated_fat
      # t.float :unsaturated_fat
      # t.float :carbohdrate
      # t.float :sugars
      # t.float :fibre
      # t.float :protein
      # t.float :salt
      t.datetime :meal_time

      t.timestamps
    end
  end
end
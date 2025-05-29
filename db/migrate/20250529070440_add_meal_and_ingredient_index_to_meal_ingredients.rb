class AddMealAndIngredientIndexToMealIngredients < ActiveRecord::Migration[8.0]
  def change
    add_index :meal_ingredients, [:meal_id, :ingredient_id], unique: true
  end
end

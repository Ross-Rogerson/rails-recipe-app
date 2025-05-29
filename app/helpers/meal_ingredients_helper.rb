module MealIngredientsHelper
  def meal_ingredient_display_name(meal_ingredient)
    "#{meal_ingredient.ingredient.name} #{meal_ingredient.quantity.to_i}#{meal_ingredient.quantity_unit}"
  end
end

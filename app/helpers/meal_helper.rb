module MealHelper
  def meal_ingredient_display_name(meal_ingredient)
    "#{meal_ingredient.ingredient.name} #{meal_ingredient.quantity.to_i}#{meal_ingredient.quantity_unit}"
  end

  def nutrition_labels
    {
      "calories_per_portion" => "Calories (kcal)",
      "saturated_fat_per_portion" => "Saturated Fat (g)",
      "unsaturated_fat_per_portion" => "Unsaturated Fat (g)",
      "carbohydrates_per_portion" => "Carbohydrates (g)",
      "sugars_per_portion" => "Sugars (g)",
      "fibre_per_portion" => "Fibre (g)",
      "protein_per_portion" => "Protein (g)",
      "salt_per_portion" => "Salt (g)"
    }
  end
end

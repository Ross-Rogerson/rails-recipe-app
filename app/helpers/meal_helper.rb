module MealHelper
  def meal_ingredient_display_name(meal_ingredient)
    "#{meal_ingredient.ingredient.name} #{meal_ingredient.quantity.to_i}#{meal_ingredient.quantity_unit}"
  end

  def nutrition_label_for(attribute)
    {
      "calories_per_100g" => "Calories (kcal)",
      "saturated_fat_per_100g" => "Saturated Fat (g)",
      "unsaturated_fat_per_100g" => "Unsaturated Fat (g)",
      "carbohydrates_per_100g" => "Carbohydrates (g)",
      "sugars_per_100g" => "Sugars (g)",
      "fibre_per_100g" => "Fibre (g)",
      "protein_per_100g" => "Protein (g)",
      "salt_per_100g" => "Salt (g)"
    }[attribute] || attribute.humanize
  end
end

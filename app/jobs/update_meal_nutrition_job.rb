class UpdateMealNutritionJob < ApplicationJob
  queue_as :default

  def perform(ingredient_id)
    ingredient = Ingredient.find_by(id: ingredient_id)
    return unless ingredient

    ingredient.meals.find_each do |meal|
      meal.calculate_nutritional_info
      meal.save!
    end
  end
end
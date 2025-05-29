class MealIngredient < ApplicationRecord
  belongs_to :meal
  belongs_to :ingredient, optional: true

  validates :quantity, :quantity_unit, presence: true

  validate :ingredient_id_presence # custom validation for ingredient_id field in meal form

  enum :quantity_unit, { g: 0, kg: 1, ml: 2, l: 3 }

  # custom validation for ingredient_id field in meal form
  def ingredient_id_presence
    if ingredient_id.blank? && (ingredient.nil? || ingredient.persisted?)
      errors.add(:ingredient_id, "must be selected")
    end
  end
end

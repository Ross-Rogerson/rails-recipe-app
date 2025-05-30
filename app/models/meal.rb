class Meal < ApplicationRecord
  belongs_to :user
  
  has_many :meal_ingredients, dependent: :destroy
  has_many :ingredients, through: :meal_ingredients

  validates :name, presence: true
  # validates :calories, :calories, :saturated_fat, :unsaturated_fat, :carbohdrate, :sugars, :fibre, :protein, :salt, numericality: { greater_than_or_equal_to: 0, allow_blank: true }
  validates :meal_ingredients, length: {minimum: 1, message: 'at least 1 ingredient required.'}
  
  validate :no_duplicate_ingredients

  scope :by_created_at, -> { order(created_at: :desc) }

  broadcasts_to ->(meal) { "meals" }, inserts_by: :prepend
  broadcasts_to ->(meal) { "meals_#{meal.user_id}" }, inserts_by: :prepend

  accepts_nested_attributes_for :meal_ingredients, allow_destroy: true

  def calculate_nutritional_info
    nutrition_attributes = %w[ calories_per_100g saturated_fat_per_100g 
      unsaturated_fat_per_100g carbohydrates_per_100g sugars_per_100g 
      fibre_per_100g protein_per_100g salt_per_100g]

    meal_ingredients.includes(:ingredient)

    nutrition_attributes.index_with do |attr|
      total = meal_ingredients.sum do |mi|
        ingredient = mi.ingredient
        next 0 unless ingredient && mi.quantity.present?
        ingredient[attr].to_f * (mi.quantity.to_f / 100.0)
      end
      total.round(2)
    end
  end

  def no_duplicate_ingredients
    ingredient_ids = meal_ingredients.map(&:ingredient_id)
    duplicates = ingredient_ids.select { |ingredient_id| ingredient_ids.count(ingredient_id) > 1 }.uniq

    if duplicates.any?
      errors.add(:base, "Each ingredient should only be listed once per meal")
    end
  end
end
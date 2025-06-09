class Meal < ApplicationRecord
  belongs_to :user
  
  has_many :meal_ingredients, dependent: :destroy
  has_many :ingredients, through: :meal_ingredients

  has_one_attached :image

  validates :name, presence: true
  validates :meal_ingredients, length: {minimum: 1, message: 'at least 1 ingredient required.'}
  
  validate :no_duplicate_ingredients

  before_save :calculate_nutritional_info

  scope :by_created_at, -> { order(created_at: :desc) }

  broadcasts_to ->(meal) { "meals" }, inserts_by: :prepend
  broadcasts_to ->(meal) { "meals_#{meal.user_id}" }, inserts_by: :prepend

  accepts_nested_attributes_for :meal_ingredients, allow_destroy: true

  INGREDIENT_TO_MEAL_NUTRITION_MAP = {
    "calories_per_100g" => "calories_per_portion",
    "saturated_fat_per_100g" => "saturated_fat_per_portion",
    "unsaturated_fat_per_100g" => "unsaturated_fat_per_portion",
    "carbohydrates_per_100g" => "carbohydrates_per_portion",
    "sugars_per_100g" => "sugars_per_portion",
    "fibre_per_100g" => "fibre_per_portion",
    "protein_per_100g" => "protein_per_portion",
    "salt_per_100g" => "salt_per_portion"
  }.freeze

  def calculate_nutritional_info
    INGREDIENT_TO_MEAL_NUTRITION_MAP.each do |ingredient_attr, meal_attr|
      total = meal_ingredients.sum do |mi|
        ingredient = mi.ingredient
        next 0 unless ingredient && mi.quantity.present?
        ingredient[ingredient_attr].to_f * (mi.quantity.to_f / 100.0)
      end
      self[meal_attr] = (total / self.portions).round(2)
    end
  end

  def no_duplicate_ingredients
    ingredient_ids = meal_ingredients.map(&:ingredient_id)
    duplicates = ingredient_ids.select { |ingredient_id| ingredient_ids.count(ingredient_id) > 1 }.uniq

    if duplicates.any?
      errors.add(:base, "Each ingredient should only be used once per meal")
    end
  end
end
class Ingredient < ApplicationRecord
  belongs_to :user

  has_many :meal_ingredients, dependent: :destroy
  has_many :meals, through: :meal_ingredients
  has_many :grocery_items, dependent: :destroy
  
  validates_presence_of :name, :calories_per_100g, :protein_per_100g, :carbohydrates_per_100g, :sugars_per_100g, :saturated_fat_per_100g, :unsaturated_fat_per_100g, :fibre_per_100g, :salt_per_100g, :category

  validates :calories_per_100g, :protein_per_100g, :carbohydrates_per_100g, :sugars_per_100g, :saturated_fat_per_100g, :unsaturated_fat_per_100g, :fibre_per_100g, :salt_per_100g, numericality: { greater_than_or_equal_to: 0 }
  validates :vegetarian, inclusion: { in: [true, false] }

  validate :require_grocery_item_if_needed

  accepts_nested_attributes_for :grocery_items, reject_if: :all_blank

  after_save :update_meal_nutritional_info, if: :saved_change_to_any_nutrient?

  scope :by_created_at, -> { order(created_at: :desc) }

  enum :category, { fruit: 0, vegetables: 1, meat: 2, fish: 3, eggs_and_dairy: 4, beans_and_pulses: 5, herbs_and_spices: 6, other: 7 }

  def require_grocery_item_if_needed
    if @require_grocery_item && grocery_items.empty?
      errors.add(:base, "Please add a grocery item")
    end
  end

  def require_grocery_item!
    @require_grocery_item = true
  end

  def saved_change_to_any_nutrient?
    saved_change_to_calories_per_100g? ||
    saved_change_to_saturated_fat_per_100g? ||
    saved_change_to_unsaturated_fat_per_100g? ||
    saved_change_to_carbohydrates_per_100g? ||
    saved_change_to_sugars_per_100g? ||
    saved_change_to_fibre_per_100g? ||
    saved_change_to_protein_per_100g? ||
    saved_change_to_salt_per_100g?
  end

  def update_meal_nutritional_info
    UpdateMealNutritionJob.perform_later(id)
  end
end
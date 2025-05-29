class GroceryItem < ApplicationRecord
  belongs_to :user
  belongs_to :ingredient, optional: true
  
  validates :name, :supermarket, :quantity, :quantity_unit, :price, presence: true
  validates :has_plastic_packaging, inclusion: { in: [true, false] }

  validate :ingredient_id_presence_unless_nested # custom validation for ingredient_id field in grocery_item form
  validate :unique_ingredient
  
  enum :supermarket, { sainsburys: 0, marks_and_spencer: 1 }
  enum :quantity_unit, { g: 0, kg: 1, ml: 2, l: 3 }

  scope :by_created_at, -> { order(created_at: :desc) }
  
  before_validation :calculate_unit_price

  QUANTITY_UNIT_CONVERSIONS = {
    "g" => 1.0,
    "kg" => 1000.0,
    "ml" => 1.0,
    "l" => 1000.0
  }.freeze

  # custom validation for ingredient_id field in grocery_item form
  def ingredient_id_presence_unless_nested
    if ingredient_id.blank? && (ingredient.nil? || ingredient.persisted?)
      errors.add(:ingredient_id, "must be selected")
    end
  end

  def unique_ingredient
    if GroceryItem.where(
        name: name,
        supermarket: supermarket,
        quantity: quantity,
        quantity_unit: quantity_unit
      ).where.not(id: id).exists?

      errors.add(:base, "Ingredient already exists with the same ")
      errors.add(:name, "") unless errors[:name].present?
      errors.add(:supermarket, "") unless errors[:supermarket].present?
      errors.add(:quantity, "") unless errors[:quantity].present?
      errors.add(:quantity_unit, "") unless errors[:quantity_unit].present?
    end
  end

  private

  def calculate_unit_price
    return unless price.present? && quantity.present? && quantity_unit.present?
    self.unit_price = (price / (quantity * QUANTITY_UNIT_CONVERSIONS[quantity_unit]).to_f) * 100
  end
end

module GroceryItemsHelper
  def grocery_item_display_name(grocery_item)
    "#{grocery_item.name} #{grocery_item.quantity.to_i}#{grocery_item.quantity_unit}"
  end
end
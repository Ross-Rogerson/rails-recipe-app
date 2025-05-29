class AddUserReferenceToIngredients < ActiveRecord::Migration[8.0]
  def change
    add_reference :ingredients, :user, null: false, foreign_key: true
  end
end
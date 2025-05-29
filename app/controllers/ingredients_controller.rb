
class IngredientsController < ApplicationController
  before_action :set_ingredient, only: %i[ show edit update destroy ]
  
  def index
    @ingredients = Ingredient.by_created_at
  end

  def show
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = current_user.ingredients.build(ingredient_params)

    if @ingredient.save
      redirect_to ingredients_path, notice: "Ingredient was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new_with_grocery_item
    @ingredient = Ingredient.new
    @ingredient.grocery_items.build
  end

  def create_with_grocery_item
    @ingredient = current_user.ingredients.build(ingredient_params)
    @ingredient.grocery_items.each { |item| item.user = current_user }
    @ingredient.require_grocery_item!

    if @ingredient.save
      redirect_to ingredients_path, notice: "Ingredient and grocery item created."
    else
      # Issue: grocery item fields not showing when form submission invalid. Solution: manually add a blank grocery item.
      @ingredient.grocery_items.build if @ingredient.grocery_items.empty?
      render :new_with_grocery_item, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @ingredient.update(ingredient_params)
      redirect_to ingredient_path, notice: "Ingredient was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @ingredient.destroy
    redirect_to ingredients_path, notice: "Ingredient was successfully destroyed."
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :calories_per_100g, :saturated_fat_per_100g, :unsaturated_fat_per_100g, :carbohydrates_per_100g, 
      :sugars_per_100g, :fibre_per_100g, :protein_per_100g, :salt_per_100g, :vegetarian, :category, grocery_items_attributes: [
        :name, :price, :quantity, :quantity_unit, :supermarket, :has_plastic_packaging])
  end

  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end
end
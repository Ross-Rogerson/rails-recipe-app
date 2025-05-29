class GroceryItemsController < ApplicationController
  before_action :set_grocery_item, only: %i[ show edit update destroy ]

  def index
    @grocery_items = GroceryItem.by_created_at
  end

  def show
  end

  def new
    @grocery_item = GroceryItem.new
  end

  def create
    @grocery_item = current_user.grocery_items.build(grocery_item_params)
    @grocery_item.ingredient = Ingredient.find_by(id: grocery_item_params[:ingredient_id])

    if @grocery_item.save
      redirect_to grocery_items_path, notice: "Grocery item was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @grocery_item.update(grocery_item_params)
      redirect_to grocery_item_path, notice: "Grocery item was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @grocery_item.destroy
    redirect_to grocery_items_path, notice: "Grocery item was successfully destroyed."
  end

  private

  def grocery_item_params
    params.require(:grocery_item).permit(:name, :price, :quantity, :quantity_unit, :supermarket, :has_plastic_packaging, :ingredient_id)
  end

  def set_grocery_item
    @grocery_item = GroceryItem.find(params[:id])
  end
end
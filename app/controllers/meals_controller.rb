
class MealsController < ApplicationController
  before_action :set_meal, only: %i[ show edit update destroy ]
  before_action :set_user, only: %i[ user_meals ]

  def index
    @meals = Meal.by_created_at
  end

  # Meals from a specific user's profile
  def user_meals
    @meals = @user.meals.order(created_at: :desc)
  end

  def show
  end

  def new
    @meal = Meal.new
    @meal.meal_ingredients.build
  end

  def create
    @meal = current_user.meals.build(meal_params)

    if @meal.save
      redirect_to meals_path, notice: "Meal was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @meal.update(meal_params)
      redirect_to meal_path, notice: "Meal was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @meal.destroy
    redirect_to meals_path, notice: "Meal was successfully destroyed."
  end

  private

  def set_meal
    @meal = Meal.find(params[:id])
  end

  def meal_params
    params.require(:meal).permit(:name, meal_ingredients_attributes: [
      :ingredient_id, :quantity, :quantity_unit, :_destroy, :id])
  end

  def set_user
    @user = params[:user_id] ? User.find(params[:user_id]) : current_user
  end
end
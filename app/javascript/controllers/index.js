import { application } from "./application"

import IngredientController from "./ingredient_controller"
application.register("ingredient", IngredientController)

import MealController from "./meal_controller"
application.register("meal", MealController)

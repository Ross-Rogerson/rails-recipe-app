firstuser = User.create!(
  email: 'firstuser@email.com',
  password: "password"
)

seconduser = User.create!(
  email: 'seconduser@email.com',
  password: "password"
)

mushrooms = Ingredient.create!(
  name: "Chestnut Mushrooms",
  calories_per_100g: 8.00,
  saturated_fat_per_100g: 0.20,
  unsaturated_fat_per_100g: 0.00,
  carbohydrates_per_100g: 0.30,
  sugars_per_100g: 0.30,
  fibre_per_100g: 0.70,
  protein_per_100g: 1.00,
  salt_per_100g: 0.01,
  vegetarian: true,
  category: "vegetables",
  user: firstuser
)

fried_mushrooms = Meal.new(
  name: "Fried mushrooms",
  portions: 2,
  user: firstuser
)

fried_mushrooms.meal_ingredients.build(
  ingredient: mushrooms,
  quantity: 700,
  quantity_unit: "g"
)

fried_mushrooms.save!
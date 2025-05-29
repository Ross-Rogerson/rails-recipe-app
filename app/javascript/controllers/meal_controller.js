import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="meal"
export default class extends Controller {

  static get targets() {
    return ['addIngredientBtn', 'removeIngredientBtn', 'ingredientRow', 'mealIngredientFields', 'template']
  }
  connect() {
    this.index = this.ingredientRowTargets.length - 1
  }

  addIngredient() {
    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, this.index)
    this.mealIngredientFieldsTarget.insertAdjacentHTML("beforeend", content)
    this.index++
  }

  removeIngredient() { 
    const row = event.target.closest('.form__row')
    const destroyField = row.querySelector('input[name*="_destroy"]')
    if (destroyField) {
      destroyField.value = "1"
      row.style.display = "none"
    } else {
      row.remove()
    }
  }
}

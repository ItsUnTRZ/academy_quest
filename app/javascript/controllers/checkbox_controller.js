import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="checkbox"
export default class extends Controller {
  submit(event) {
    const checkbox = this.element
    const questItem = checkbox.closest(".quest-item")
    const questNameDiv = questItem.querySelector(".text-lg")

    if (checkbox.checked) {
      questNameDiv.classList.add("line-through", "text-gray-400")
      questNameDiv.classList.remove("text-gray-900")
      questItem.classList.add("border-green-200", "bg-green-50")
      questItem.classList.remove("border-gray-200", "hover:border-indigo-300")
    } else {
      questNameDiv.classList.remove("line-through", "text-gray-400")
      questNameDiv.classList.add("text-gray-900")
      questItem.classList.remove("border-green-200", "bg-green-50")
      questItem.classList.add("border-gray-200", "hover:border-indigo-300")
    }

    this.element.closest("form").requestSubmit()
  }
}

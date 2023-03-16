import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["dropdown"]

  toggle(evt) {
    this.dropdownTarget.classList.toggle('d-none')
    console.log(this.dropdownTarget);
  }
}

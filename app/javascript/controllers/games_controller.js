import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="games"
export default class extends Controller {
  static targets = ["input", "list", "card"]
  static values = {id: String}

  connect() {
    console.log(this.inputTarget)
  }

  playlist(event) {

    this.inputTarget.value = event.currentTarget.attributes.uri.value;

    // Add class active to the clicked playlist
    this.cardTargets.forEach((elem) => { elem.classList.remove("active") } )
    event.currentTarget.classList.add("active")
  }

  async updatelist(evt) {
    const response = await fetch(`/list?query=${evt.target.value}`)
    const data = await response.json();
    this.listTarget.innerHTML = data.html
  }
}

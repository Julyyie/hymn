import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="buzzer"
export default class extends Controller {
  connect() {
    this.element.href = this.element.href + `?timestamp=${this._generateTimestamp()}`
  }
  _generateTimestamp() {
    return Date.now()
  }
}

import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="game-subscription"
export default class extends Controller {
  static values = { gameId: Number, gameMaster: Boolean }
  static targets = ["players"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "GameChannel", id: this.gameIdValue },
      { received: data => this.#handleEvent(data) }
    )
    console.log(`Subscribe to the chatroom with the id ${this.gameIdValue}.`)
  }

  #handleEvent(data) {
    if (data["event"] === "player_joined") {
      this.playersTarget.insertAdjacentHTML("beforeend", data["html"])
    } else if (data["event"] === "game_started" && this.gameMasterValue === false ) {
      window.location.assign(data["url"])
    }
  }
}

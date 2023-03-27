import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"
import { Modal } from "bootstrap/dist/js/bootstrap.bundle.js"

// Connects to data-controller="answers-index-subscription"
export default class extends Controller {
  static values = {
    songId: Number,
    currentUserId: Number,
    gameMaster: Boolean
  }
  static targets = ["answers", "close"]

  connect() {
    this.token = document.querySelector('meta[name="csrf-token"]').content
    this.channel = createConsumer().subscriptions.create(
      { channel: "AnswersIndexChannel", song_id: this.songIdValue },
      { received: (data) => {
          if (data["event"] === "player_buzzed" && this.gameMasterValue === true) {
            this.answersTarget.insertAdjacentHTML("beforeend", data.answer);
            this.answersTarget.insertAdjacentHTML("beforeend", data.answer_modal)
          }
          else if (data["event"] === "next_song" && this.gameMasterValue === false) {
            window.location.assign(data["url"])
          } else if (data["event"] === "game_finished" && this.gameMasterValue === false) {
          window.location.assign(data["url"])
          } else if (data["event"] === "answer_updated") {
            if (this.gameMasterValue === true) {
              document.querySelector(`#Modal${data["users_game_id"]} .btn-close`).click()
            }
            setTimeout(() => {
              this.answersTarget.innerHTML = data["answers"]
            }, 100);
          }
        }
      }
    )
    }

    updateStatus(event) {
      event.preventDefault()
      fetch(event.currentTarget.href, {
        method: "PATCH",
        headers: {
          "Accept": "text/plain",
          "X-CSRF-TOKEN": this.token
        }})
    }
  }

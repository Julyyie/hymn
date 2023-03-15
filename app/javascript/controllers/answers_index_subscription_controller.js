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
  static targets = ["answers"]

  connect() {
    console.log(this.gameMasterValue)
    this.token = document.querySelector('meta[name="csrf-token"]').content
    this.channel = createConsumer().subscriptions.create(
      { channel: "AnswersIndexChannel", song_id: this.songIdValue },
      { received: (data) => {
          console.log(data)
          // const currentUserIsGameMaster = this.currentUserIdValue === data.game_master_id
          // console.log(currentUserIsGameMaster);
          if (data["event"] === "player_buzzed" && this.gameMasterValue === true) {
            this.answersTarget.insertAdjacentHTML("beforeend", data.answer);
            this.answersTarget.insertAdjacentHTML("beforeend", data.answer_modal)
          }
          else if (data["event"] === "next_song" && this.gameMasterValue === false) {
            window.location.assign(data["url"])
          } else if (data["event"] === "game_finished" && this.gameMasterValue === false) {
          window.location.assign(data["url"])
          } else if (data["event"] === "answer_updated") {
            const modal = Modal.getInstance(`#Modal${data["users_game_id"]}`);
            modal.hide();

            setTimeout(() => {
              document.querySelectorAll(".modal-backdrop").forEach((modal) => {
                modal.remove();
              })
            }, 100);

            this.answersTarget.innerHTML = data["answers"]
          }
        }
      }
    )
    }

    updateStatus(event) {
      event.preventDefault()
      console.log("hello")
      fetch(event.currentTarget.href, {
        method: "PATCH",
        headers: {
          "Accept": "text/plain",
          "X-CSRF-TOKEN": this.token
        }})
    }
  }

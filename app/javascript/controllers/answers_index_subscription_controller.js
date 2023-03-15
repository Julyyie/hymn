import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="answers-index-subscription"
export default class extends Controller {
  static values = {
    songId: Number,
    currentUserId: Number,
    gameMaster: Boolean
  }
  static targets = ["answers", "links"]

  connect() {
    console.log(this.gameMasterValue)
    this.channel = createConsumer().subscriptions.create(
      { channel: "AnswersIndexChannel", song_id: this.songIdValue },
      { received: (data) => {
          console.log(data)

          // const currentUserIsGameMaster = this.currentUserIdValue === data.game_master_id
          // console.log(currentUserIsGameMaster);
          if (this.gameMasterValue == true) {
            this.answersTarget.insertAdjacentHTML("beforeend", data.answer);
            // this.linksTarget.insertAdjacentHTML("beforeend", data.answer_links)
          }
          else if (data["event"] === "next_song") {
            window.location.assign(data["url"])
          }
        }
      }
    )
    }
  }

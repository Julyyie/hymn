import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="explanation"
export default class extends Controller {
  static targets = ["text"]

  connect() {
    this.index = 0;
    this.messages = [
      "🤫 Psss: if you find before 1 second you win a bonus!",
      "🤭 Who will be the first to buzz in for maximum points?",
      "Be careful, if you buzz without knowing the answer, you will have a malus 😈",
      "Do not say your answer without the game master giving you the floor 🙀",
      "Basic rules : you win 10 pts per good answer 🎉, lose 5 pts per wrong answer",
      "If you find the answer under 3sec you win 10pts, under 5sec you win 5pts 🌟"
    ];


    this.#scheduleExplanation()
  }

  #scheduleExplanation() {
    // console.log(this)

    setInterval(() => {
      // console.log(this)
      const message = this.messages[this.index % this.messages.length]
      this.index += 1
      this.textTarget.style.opacity = '0%'

      setTimeout(() => {
        this.textTarget.innerText = message
        this.textTarget.style.opacity = "100%"
      }, 700);

    }, 3000);
  }
}

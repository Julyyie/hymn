import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="explanation"
export default class extends Controller {
  connect() {
    const messages = ["🤫 Psss: if you find before 1 second you win a bonus!",
    "🤭 Who will be the first to buzz in for maximum points?",
    "Be careful, if you buzz without knowing the answer, you will have a malus 😈",
    "Do not say your answer without the game master giving you the floor 🙀",
    "Basic rules : you win 10 pts per good answer 🎉, lose 5 pts per wrong answer",
    "If you find the answer under 3sec you win 10pts, under 5sec you win 5pts 🌟"
  ];

    // messages.forEach((message) => {
    //   setTimeout(function this.element(messages) {

    //   }, 1000);
    // });
    // 1. Sur chaque message
    // 2. J'attends 10 secondes (setTimeout(callback, 10000))
    // 3. Je sélectionne mon p console.log(this.element);
    // 4. Je changer l'innerHTML avec le contenu du message

  }


}

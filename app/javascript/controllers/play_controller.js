import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="play"
export default class extends Controller {
  connect() {
    console.log('hello from play');
    setTimeout(() => {

      let iframe = document.querySelector('iframe');
      console.log(iframe);
      iframe = iframe.contentDocument || iframe.contentWindow.document;
      console.log(iframe);
      const playButton = document.querySelector('button.zxky3zhmh_vhWlndRKVG')
      console.log(playButton);
      playButton.click();
      iframe.addEventListener('load', (event) => {
        console.log('loaded');
      })
    }, 4000);
  }

  play() {
      const playButton = document.querySelector("button.zxky3zhmh_vhWlndRKVG");
      console.log(playButton);
      playButton.click();
  }
}

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Hello from FlashController!")

    setTimeout(() => {
      this.element.remove()
    }, 3000)
  }
}
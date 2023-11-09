import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="messages"
export default class extends Controller {
  static targets = ["messages"];
  connect() {}

  clearForm() {
    this.element.reset();
  }
}

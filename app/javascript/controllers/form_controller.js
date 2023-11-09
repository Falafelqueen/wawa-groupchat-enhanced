import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="messages"
export default class extends Controller {
  static targets = ["messages"];
  connect() {
    console.log("Form controller connected");
  }

  clearForm() {
    console.log("Clearing form");
    this.element.reset();
  }
}

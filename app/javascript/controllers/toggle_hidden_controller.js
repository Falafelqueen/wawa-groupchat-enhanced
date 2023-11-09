import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="toggle-hidden"
export default class extends Controller {
  static targets = ["form", "btn"];
  connect() {}

  show(e) {
    this.formTarget.classList.remove("hidden");
    e.target.classList.add("hidden");
  }

  hide(e) {
    e.target.classList.add("hidden");
    this.btnTarget.classList.remove("hidden");
  }
}

import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="get-pokemon"
export default class extends Controller {

  static targets = ["slot", "teamContext", "question"];

  connect() {
    console.log("Hello from the controller");

    this.values = this.slotTargets.map((el) => el.value || "");
    this.writeContext();
  }

  capture(event) {
    const index = Number(event.target.dataset.slotIndex);
    this.values[index] = event.target.value;
    this.writeContext();
  }

  // Called on "Ask AI" button click (before submit)
  inject() {
    this.writeContext()
  }

  writeContext() {
    // Keep only chosen IDs; blanks mean "AI recommendation"
    const payload = {
      pokemon_ids: this.values,
      filled_ids: this.values.filter((v) => v && v.length > 0)
    };

    if (this.hasTeamContextTarget) {
      this.teamContextTarget.value = JSON.stringify(payload);
    };
  }
}

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "input" ]

  select(event) {
    // 1. すべてのカードから 'selected' クラスを消す
    this.element.querySelectorAll('.card').forEach(card => {
      card.classList.remove('selected')
    })

    // 2. クリックされたカードに 'selected' クラスをつける
    const selectedCard = event.currentTarget
    selectedCard.classList.add('selected')

    // 3. 隠しフォーム(hidden_field)に、カードの data-version-value を入れる
    this.inputTarget.value = selectedCard.dataset.versionValue
  }
}

import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static get targets() {
    return ['nextBtn', 'prevBtn', 'submitBtn', 'stepMarker', 'stepLabel', 'formPage', 'stepConnector']
  }

  connect() {
    if (this.formPageTargets.length > 1) {
      this.pageIndex = 0
      if (this.stepMarkerTargets.length > 0) {
        this.stepMarkerTargets[0].classList.add('progress-bar__step-marker--active')
        this.stepLabelTargets[0].classList.add('progress-bar__step-label--active')
      }
      this.disableBtns()
    }
  }

  goNext() {
    this.pageIndex += 1
    this.updateProgressBar(1)
    this.navigateForm(1)
  }

  goPrevious() {
    this.pageIndex -= 1
    this.updateProgressBar(-1)
    this.navigateForm(-1)
  }

  updateProgressBar(direction) {
    if (direction > 0) {
      // add complete class origin stepMarker and connector
      this.stepMarkerTargets[this.pageIndex - direction].classList.add('progress-bar__step-marker--complete')
      this.stepLabelTargets[this.pageIndex - direction].classList.add('progress-bar__step-label--complete')
      this.stepConnectorTargets[this.pageIndex - direction].classList.add('progress-bar__step-connector--complete')
    } else {
      // remove complete class from target stepMarker and connector
      this.stepMarkerTargets[this.pageIndex].classList.remove('progress-bar__step-marker--complete')
      this.stepConnectorTargets[this.pageIndex].classList.remove('progress-bar__step-connector--complete')
      this.stepLabelTargets[this.pageIndex].classList.remove('progress-bar__step-label--complete')
    }

    // remove active class from origin stepMarker
    this.stepMarkerTargets[this.pageIndex - direction].classList.remove('progress-bar__step-marker--active')
    this.stepLabelTargets[this.pageIndex - direction].classList.remove('progress-bar__step-label--active')

    // add active class to target stepMarker
    this.stepMarkerTargets[this.pageIndex].classList.add('progress-bar__step-marker--active')
    this.stepLabelTargets[this.pageIndex].classList.add('progress-bar__step-label--active')

    this.disableBtns()
  }

  navigateForm(direction) {
    if (this.formPageTargets[this.pageIndex]) this.formPageTargets[this.pageIndex].classList.remove('visually-hidden')
    if (this.formPageTargets[this.pageIndex - direction]) this.formPageTargets[this.pageIndex - direction].classList.add('visually-hidden')
  }

  disableBtns() {
    if (this.hasPrevBtnTarget) this.prevBtnTarget.disabled = this.pageIndex === 0
    if (this.hasNextBtnTarget) this.nextBtnTarget.disabled = this.pageIndex === this.stepMarkerTargets.length - 1
    if (this.hasSubmitBtnTarget) this.submitBtnTarget.disabled = this.pageIndex !== this.stepMarkerTargets.length - 1
  }
}
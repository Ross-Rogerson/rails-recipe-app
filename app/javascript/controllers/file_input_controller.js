import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="file-input"
export default class extends Controller {

  static get targets() {
    return ['fileInputLabel', 'fileInput']
  }
  connect() {
    const currentLabel = this.fileInputLabelTarget.textContent.trim()
    this.truncateFileName(currentLabel)
  }

  updateFilename() {
    const file = this.fileInputTarget.files[0]
    if (file) {
      const fileName = file.name?.trim()
      this.truncateFileName(fileName)
    }
  }

  truncateFileName(fileName) {
    const maxLength = 15
    let label
    if (fileName.length > maxLength) {
      label = fileName?.trim().substring(0, Math.min(maxLength, fileName.length)) + '...'
    } else {
      label = fileName
    }
    this.fileInputLabelTarget.textContent = label
  }
}

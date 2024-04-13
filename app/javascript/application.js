// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-r
// import Rails from "@rails/ujs"
import { Turbo } from  "@hotwired/turbo-rails"
import "controllers"
//Rails.start()
Turbo.session.drive = false

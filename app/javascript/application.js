// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-r
// import Rails from "@rails/ujs"
import { Turbo } from  "@hotwired/turbo-rails"
import "controllers"
//Rails.start()
Turbo.session.drive = false

document.addEventListener('turbolinks:load', () => {
  document.querySelectorAll('.favorite-toggle').forEach((element) => {
    element.addEventListener('click', (event) => {
      event.preventDefault();
      const restaurantId = element.dataset.restaurantId;
      const isFavorite = element.dataset.favorite === 'true';

      // Here you would send the AJAX request to update the favorite status.
      // For Rails UJS it might look something like this:
      // Rails.ajax({
      //   url: `/restaurants/${restaurantId}/toggle_favorite`,
      //   type: 'POST',
      //   data: new FormData(),
      //   success: function() {
      //     // On success, toggle the icon and color
      //     toggleFavoriteIcon(element, isFavorite);
      //   }
      // });

      // If you are not using AJAX, you might want to submit a form instead
      // or handle the toggling in the response of a normal Rails request.
    });
  });
});

function toggleFavoriteIcon(element, isFavorite) {
  element.dataset.favorite = isFavorite ? 'false' : 'true';
  const icon = element.querySelector('i');
  if (isFavorite) {
    icon.classList.remove('fa-star');
    icon.classList.add('fa-star-o');
    icon.style.color = 'black';
  } else {
    icon.classList.remove('fa-star-o');
    icon.classList.add('fa-star');
    icon.style.color = 'yellow';
  }
}


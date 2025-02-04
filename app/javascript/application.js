// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "./controllers";
import * as bootstrap from "bootstrap";

document.addEventListener("turbo:load", function() {
    document.querySelectorAll(".clickable-row").forEach(row => {
      row.addEventListener("click", function() {
        console.log("Redirecting to:", this.dataset.href); // Debugging
        Turbo.visit(this.dataset.href, { action: "replace" }); // Use Turbo to navigate
      });
    });
  });

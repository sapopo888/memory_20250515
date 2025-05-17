// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import { PageFlip } from "page-flip";

document.addEventListener("DOMContentLoaded", () => {
  const elm = document.getElementById("book");

  if (elm) {
    const pageFlip = new PageFlip(document.getElementById('book'), {
      width: 400,
      height: 600,
    });

    pageFlip.loadFromHTML(document.querySelectorAll('.my-page'));
  }
});

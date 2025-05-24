import { PageFlip } from "page-flip";

document.addEventListener("turbo:load", () => {
  const elm = document.getElementById("book");

  if (elm) {
    const pageFlip = new PageFlip(document.getElementById('book'), {
      width: 600,
      height: 600,
      showCover: true
    });

    pageFlip.loadFromHTML(document.querySelectorAll('.my-page'));
  }
});

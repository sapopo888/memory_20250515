import { PageFlip } from "page-flip";

document.addEventListener("turbo:load", () => {
  const elm = document.getElementById("book");

  if (elm) {
    const pageFlip = new PageFlip(document.getElementById('book'), {
      width: 400,
      height: 600,
    });

    pageFlip.loadFromHTML(document.querySelectorAll('.my-page'));
  }
});

document.addEventListener("turbo:load", () => {
  const button = document.getElementById('js-myPage-button');
  const dropdown = document.getElementById('js-dropdown')

  button.addEventListener('click', (e) => {
    e.stopPropagation(); // 他のクリックイベントをストップ
    dropdown.classList.toggle("hidden");
  });

  // メニュー外をクリックしたらメニューを閉じる
  document.addEventListener('click', (e) => {
    if (!dropdown.classList.contains("hidden")) {
      dropdown.classList.add("hidden");
    }
  });

  // ドロップダウン内クリック時に閉じないようにする
  dropdown.addEventListener("click", (e) => {
    e.stopPropagation();
  });
});

(function () {
  const setImage = [
    "images/slider01.jpg",
    "images/slider02.jpg",
    "images/slider03.jpg",
    "images/slider04.jpg",
  ];
  const view = document.getElementById("view");
  const prev = document.getElementById("prev");
  const next = document.getElementById("next");

  let list;
  let image;
  let current = 0;
  let clickBtn = true;

  function createThumbnailItem() {
    for (let i = 0; i < setImage.length; i++) {
      list = document.createElement("li");
      image = document.createElement("img");
      image.src = setImage[i];
      list.appendChild(image);

      if (i === 0) {
        list.classList.add("selected");
      }

      list.addEventListener("click", function () {
        view.src = this.children[0].src;

        for (let j = 0; j < thumbnailList.children.length; j++) {
          thumbnailList.children[j].classList.remove("selected");
        }
        this.classList.add("selected");
        let currentImage = this.children[0].src.slice(-6, -4);
        current = Number(currentImage) - 1;
      });
    }
  }
  createThumbnailItem();

  prev.addEventListener("click", function () {
    if (clickBtn === true) {
      clickBtn = false;
      view.classList.add("appear");
      thumbnailList.children[current].classList.remove("selected");
      current--;
      if (current < 0) {
        current = setImage.length - 1;
      }
      view.src = setImage[current];
      thumbnailList.children[current].classList.add("selected");
      setTimeout('view.classList.remove("appear");', 2100);
      setTimeout(function () {
        clickBtn = true;
      }, 2100);
    } else {
      return false;
    }
  });

  next.addEventListener("click", function () {
    if (clickBtn === true) {
      clickBtn = false;
      view.classList.add("appear");
      current++;
      if (current > setImage.length - 1) {
        current = 0;
      }
      view.src = setImage[current];
      setTimeout('view.classList.remove("appear");', 2100);
      setTimeout(function () {
        clickBtn = true;
      }, 2100);
    } else {
      return false;
    }
  });

  function autoPlay() {
    setTimeout(function () {
      next.click();
      autoPlay();
    }, 5000);
  }
  window.onload = autoPlay();
})();

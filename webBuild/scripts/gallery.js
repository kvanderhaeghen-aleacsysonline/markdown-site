
function addImages() {
  images.forEach((image) => {
    let container = document.getElementById('imagesContainer');
    let img = document.createElement('img');
    img.src = image;
    img.classList.add('gallery-img');
    img.onclick = function() {
      showImage(img.src);
    };
    container.appendChild(img);
  });
}

function showImage(imageSrc) {
  let popupImage = document.getElementById("popupImage");
  popupImage.src = imageSrc;
   
  let imagePopup = document.getElementById("imagePopupContainer");
  imagePopup.style.display = "block";
  document.body.style.overflow = "hidden";
}

// function to hide the image when we click on cross button
function closeImage() {
  let imagePopup = document.getElementById("imagePopupContainer");
  imagePopup.style.display = "none";
 document.body.style.overflow = "auto";
}

addImages();
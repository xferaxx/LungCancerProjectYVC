window.onload = function () {

  // Definitions
  var canvas = document.getElementById("paint-canvas");
  var context = canvas.getContext("2d");
  var boundings = canvas.getBoundingClientRect();

  canvas.width = 400;
  canvas.height = 300;

  const image1 = new Image();
  image1.src = document.getElementById('newMahdeCanvas').value;

  image1.addEventListener('load', function () {
    context.drawImage(image1, 0, 0, canvas.width, canvas.height);
  })


  // Specifications
  var mouseX = 0;
  var mouseY = 0;
  context.strokeStyle = 'green'; // initial brush color
  context.lineWidth = 7; // initial brush width
  var isDrawing = false;


  // Handle Colors
  var colors = document.getElementsByClassName('colors')[0];

  colors.addEventListener('click', function (event) {
    context.strokeStyle = event.target.value || 'black';
  });

  // Handle Brushes
  var brushes = document.getElementsByClassName('brushes')[0];

  brushes.addEventListener('click', function (event) {
    context.lineWidth = event.target.value || 1;
  });

  // Mouse Down Event
  canvas.addEventListener('mousedown', function (event) {
    setMouseCoordinates(event);
    isDrawing = true;

    // Start Drawing
    context.beginPath();
    context.moveTo(mouseX, mouseY);
  });

  // Mouse Move Event
  canvas.addEventListener('mousemove', function (event) {
    setMouseCoordinates(event);

    if (isDrawing) {
      context.lineTo(mouseX, mouseY);
      context.stroke();
    }
  });

  // Mouse Up Event
  canvas.addEventListener('mouseup', function (event) {
    setMouseCoordinates(event);
    isDrawing = false;
  });

  // Handle Mouse Coordinates
  function setMouseCoordinates(event) {
    mouseX = event.clientX - boundings.left;
    mouseY = event.clientY - boundings.top;
  }

  // Handle Clear Button
  var clearButton = document.getElementById('clear');

  clearButton.addEventListener('click', function () {
    context.clearRect(0, 0, canvas.width, canvas.height);
  });

  // Handle Save Button
  var saveButton = document.getElementById('save');

  saveButton.addEventListener('click', function () {
    var imageName = prompt('Please enter image name');
    var canvasDataURL = canvas.toDataURL();
    var a = document.createElement('a');
    a.href = canvasDataURL;
    a.download = imageName || 'drawing';
    a.click();
  });


  document.querySelector("#myForm").addEventListener("submit", function (e) {
    document.getElementById('mahdeCanvas').value = canvas.toDataURL("image/jpeg");
    e.preventDefault();
    document.getElementById('myForm').submit();
  });
};

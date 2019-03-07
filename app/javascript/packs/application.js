import "bootstrap";

const toggleFixed = () => {
    var parentwidth = $(".question-container").width();
    $(".progress").width(parentwidth).css("position", "fixed").css("bottom", "16px");;
}

if (window.location.pathname.includes('/takedeck')) {
  toggleFixed();
}


// Left Navbar JS
const toggleSelectedView = () => {
  const selected = document.querySelector(.selected);
  selected.addEventListener("click", (event) => {
    console.log("event selector works!")
  });
}

if (window.location.pathname.includes('/takedeck')) {
  toggleFixed();
}

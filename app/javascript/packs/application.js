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
  const menuLinks = document.querySelectorAll(".menu-item");
  menuLinks.forEach ((link) => {
    link.addEventListener("click", (event) => {
    console.log ("work")
    const selected = document.querySelector(".selected");
    event.currentTarget.classList.toggle("selected");
    selected.classList.toggle("selected");
    });
  });
}

if (window.location.pathname.includes('/curriculums')) {
  toggleSelectedView();
}

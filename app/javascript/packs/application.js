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
  const sections = document.querySelector(".sections");
  const curriculums = document.querySelector(".curriculums");
  menuLinks.forEach ((link) => {
    link.addEventListener("click", (event) => {
      const selected = document.querySelector(".selected");
      selected.classList.toggle("selected");
      event.currentTarget.classList.toggle("selected");
      if (event.currentTarget.innerText === "My Sections") {
        curriculums.setAttribute("hidden", "")
        sections.removeAttribute("hidden", "")
      }
      if (event.currentTarget.innerText === "My Curriculums") {
        sections.setAttribute("hidden", "")
        curriculums.removeAttribute("hidden", "")
      };
    });
  });
}

if (window.location.pathname.includes('/curriculums')) {
  toggleSelectedView();
}

import "bootstrap";

// Get container width for progress bar
const toggleFixed = () => {
  var parentwidth = $(".question-container").width();
  $(".progress").width(parentwidth).css("position", "fixed").css("bottom", "16px");
}

// Expand answer card
const expandCard = () => {
  document.querySelectorAll(".expand-card").forEach((expand) => {
    expand.addEventListener("click", (event) => {
      event.currentTarget.parentElement.style.display = 'none';
      event.currentTarget.parentElement.parentElement.querySelector(".long-answer").style.display = 'block';
    });
  });
}

// Collapse answer card
const collapseCard = () => {
  document.querySelectorAll(".collapse-card").forEach((collapse) => {
    collapse.addEventListener("click", (event) => {
      event.currentTarget.parentElement.style.display = 'none';
      event.currentTarget.parentElement.parentElement.querySelector(".short-answer").style.display = 'block';
    });
  });
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

if (window.location.pathname.includes('/decksummary')) {
  expandCard();
  collapseCard();
}

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

// Left Navbar Selection
const toggleSelectedMenuItem = () => {
  const menuLinks = document.querySelectorAll(".menu-item");
  const sections = document.querySelectorAll(".sections");
  const curriculums = document.querySelectorAll(".curriculums");
  menuLinks.forEach ((link) => {
    link.addEventListener("click", (event) => {
      const selected = document.querySelector(".selected");
      selected.classList.toggle("selected");
      event.currentTarget.classList.toggle("selected");
      if (event.currentTarget.innerText === "My Sections") {
        curriculums.forEach ((curriculum) => {
          curriculum.setAttribute("hidden", "")
        });
        sections.forEach ((section) => {
          section.removeAttribute("hidden", "")
        });
      };
      if (event.currentTarget.innerText === "My Curriculums") {
        curriculums.forEach ((curriculum) => {
          curriculum.removeAttribute("hidden", "")
        });
        sections.forEach ((section) => {
          section.setAttribute("hidden", "")
        });
      };
    });
  });
}

toggleSelectedMenuItem()

if (window.location.pathname.includes('/decksummary')) {
  expandCard();
  collapseCard();
}

import 'hammerjs';

// Get a reference to an element.
var card = document.querySelector('.question-card');

// Create an instance of Hammer with the reference.
var hammer = new Hammer(card);

// Subscribe to a quick start event: press, tap, or doubletap.
// For a full list of quick start events, read the documentation.
hammer.on('swipe', function(e) {
  console.log("You're swiping me!");
  if (e.offsetDirection === 2) {
    console.log("left");
    $(".question-card").animate({left: "-1000px"});
  };
  if (e.offsetDirection === 4) {
    $(".question-card").animate({right: "-1000px"});
  };
});

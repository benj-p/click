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

var myBlock = document.querySelector('.question-card');

// create a simple instance on our object
var mc = new Hammer(myBlock);

// add a "PAN" recognizer to it (all directions)
mc.add( new Hammer.Pan({ direction: Hammer.DIRECTION_ALL, threshold: 0 }) );

// tie in the handler that will be called
mc.on("pan", handleDrag);

// poor choice here, but to keep it simple
// setting up a few vars to keep track of things.
// at issue is these values need to be encapsulated
// in some scope other than global.
var lastPosX = 0;
var lastPosY = 0;
var isDragging = false;
function handleDrag(ev) {

  // for convience, let's get a reference to our object
  var elem = ev.target;

  // DRAG STARTED
  // here, let's snag the current position
  // and keep track of the fact that we're dragging
  if ( ! isDragging ) {
    isDragging = true;
    lastPosX = elem.offsetLeft;
    lastPosY = elem.offsetTop;
  }

  // we simply need to determine where the x,y of this
  // object is relative to where it's "last" known position is
  // NOTE:
  //    deltaX and deltaY are cumulative
  // Thus we need to always calculate 'real x and y' relative
  // to the "lastPosX/Y"
  var posX = ev.deltaX + lastPosX;
  var posY = ev.deltaY + lastPosY;

  // move our element to that position
  elem.style.left = posX + "px";
  elem.style.top = posY + "px";

  // DRAG ENDED
  // this is where we simply forget we are dragging
  if (ev.isFinal) {
    isDragging = false;
  }
}
